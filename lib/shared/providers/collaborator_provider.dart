import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';

import '../../core/entity/trip_entity.dart';
import '../../core/failures/failure.dart';
import '../../repositories/collaborator_repository.dart';

class CollaboratorProvider extends ChangeNotifier {
  final ICollaboratorRepository repository;

  CollaboratorProvider(this.repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<TripEntity>? _trips;
  List<TripEntity>? get trips => _trips;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getAllTripsByTraveler({
    required String travelerId,
    required String responsibleId,
  }) async {
    _setLoading(true);

    final result = await repository.getTripsByTravelerId(
      travelerId: travelerId,
      responsibleId: responsibleId,
    );

    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );

    _setLoading(false);
  }

  Future<void> getAllTripsByResponsible({required String responsibleId}) async {
    _setLoading(true);

    final result =
        await repository.getAllTripsByResponsible(responsibleId: responsibleId);

    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );

    _setLoading(false);
  }

  void orderByAlphabetic({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = [...list]..sort((a, b) {
        final nameA = a.travelerEntity.fullName.toLowerCase();
        final nameB = b.travelerEntity.fullName.toLowerCase();
        return isAscending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
      });
    notifyListeners();
  }

  void orderByCreatedTime({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = [...list]..sort((a, b) {
        return isAscending ? a.time.compareTo(b.time) : b.time.compareTo(a.time);
      });
    notifyListeners();
  }

  void orderByStatus({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = [...list]..sort((a, b) {
        return isAscending
            ? a.isDone.toString().compareTo(b.isDone.toString())
            : b.isDone.toString().compareTo(a.isDone.toString());
      });
    notifyListeners();
  }
}
