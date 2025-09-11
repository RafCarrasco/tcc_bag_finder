import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/failure.dart';
import '../../infra/repositories/trip_repository_impl.dart';

class TripProvider extends ChangeNotifier {
  final TripRepositoryImpl repository;

  TripProvider(this.repository);

  List<TripEntity>? _trips;
  bool _isLoading = false;

  List<TripEntity>? get trips => _trips;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Either<Failure, TripEntity>> addTrip({required TripEntity trip}) async {
    _setLoading(true);
    final result = await repository.addTrip(trip: trip);
    result.fold((l) {}, (created) {
      _trips = (_trips ?? [])..add(created);
    });
    _setLoading(false);
    return result;
  }

  Future<void> getTripsByResponsibleId(String collaboratorId) async {
    _setLoading(true);
    final result = await repository.getAllTripsByResponsibleId(
      responsibleCollaboratorId: collaboratorId,
    );
    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );
    _setLoading(false);
  }

  Future<void> getTripsById(String tripId) async {
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
    _trips!.sort((a, b) {
      if (ascending) {
        return a.createdAt.compareTo(b.createdAt);
      } else {
        return b.createdAt.compareTo(a.createdAt);
      }
    });
    notifyListeners();
  }

  void orderTripsByUpdatedTime({bool ascending = true}) {
    if (_trips == null) return;
    
    _trips!.sort((a, b) {
      if (a.updatedAt == null && b.updatedAt == null) return 0;
      
      if (a.updatedAt == null) return ascending ? -1 : 1;
      if (b.updatedAt == null) return ascending ? 1 : -1;
      
      if (ascending) {
        return a.updatedAt!.compareTo(b.updatedAt!);
      } else {
        return b.updatedAt!.compareTo(a.updatedAt!);
      }
    });
    notifyListeners();
  }
}
