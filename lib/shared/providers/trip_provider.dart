import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/failure.dart';
import '../../core/failures/trip_failure.dart';
import '../../data/datasources/trip_remote_datasource.dart';
import '../../infra/repositories/trip_repository_impl.dart';
import '../../features/auth/controller/auth_controller.dart';

class TripProvider extends ChangeNotifier {
  final TripRepositoryImpl repository;
  final AuthService authService;
  final TripRemoteDataSource remoteDataSource;

  TripProvider(this.repository, this.authService, this.remoteDataSource);

  List<TripEntity>? _trips;
  bool _isLoading = false;

  List<TripEntity>? get trips => _trips;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Either<Failure, TripEntity>> addTrip({required TripEntity trip}) async {
    if (authService.user == null) {
      return Left(TripCreateError());
    }

    final tripWithResponsible = trip.copyWith(
      responsibleCollaboratorId: authService.user!.id,
    );

    _setLoading(true);
    final result = await repository.addTrip(trip: tripWithResponsible);
    result.fold((l) {}, (created) {
      _trips = (_trips ?? [])..add(created);
    });
    _setLoading(false);
    return result;
  }

  Future<void> getTripsByCurrentUser() async {
    if (authService.user == null) {
      _trips = [];
      notifyListeners();
      return;
    }

    _setLoading(true);
    final result = await repository.getAllTripsByResponsibleId(
      responsibleCollaboratorId: authService.user!.id,
    );
    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );
    _setLoading(false);
  }

  Future<void> getTripById(String tripId) async {
    _setLoading(true);
    final result = await repository.getTripsById(tripId: tripId);
    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );
    _setLoading(false);
  }

  void orderTripsByCreatedTime({bool ascending = true}) {
    if (_trips == null) return;
    _trips!.sort((a, b) =>
        ascending ? a.createdAt.compareTo(b.createdAt) : b.createdAt.compareTo(a.createdAt));
    notifyListeners();
  }

  void orderTripsByUpdatedTime({bool ascending = true}) {
    if (_trips == null) return;
    _trips!.sort((a, b) {
      if (a.createdAt == null && b.createdAt == null) return 0;
      if (a.createdAt == null) return ascending ? -1 : 1;
      if (b.createdAt == null) return ascending ? 1 : -1;
      return ascending
          ? a.createdAt!.compareTo(b.createdAt!)
          : b.createdAt!.compareTo(a.createdAt!);
    });
    notifyListeners();
  }
  Future<void> createFullTripTransaction(Map<String, dynamic> tripTransactionData) async {
    try {
      await remoteDataSource.initTripTransaction(tripTransactionData);
    } catch (e) {
      rethrow; 
    }
  }
}