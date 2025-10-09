import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/admin_failure.dart';
import '../../repositories/admin_repository.dart';

class AdminProvider extends ChangeNotifier {
  final IAdminRepository repository;

  AdminProvider(this.repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CollaboratorEntity>? _collaborators;
  List<CollaboratorEntity>? get collaborators => _collaborators;

  List<TripEntity>? _collaboratorTrips;
  List<TripEntity>? get collaboratorTrips => _collaboratorTrips;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getCollaborators() async {
    _setLoading(true);

    final result = await repository.getCollaborators();

    result.fold(
      (failure) => _collaborators = [],
      (list) => _collaborators = list,
    );

    _setLoading(false);
  }

  Future<void> getCollaboratorTripsByCollaboratorId({
    required String collaboratorId,
  }) async {
    _setLoading(true);

    final result =
    await repository.getCollaboratorTripsByCollaboratorId(
      collaboratorId: collaboratorId,
    );


    result.fold(
      (failure) => _collaboratorTrips = [],
      (list) => _collaboratorTrips = list,
    );

    _setLoading(false);
  }

  Future<void> getCollaboratorsByName({
    required String name,
    required String responsibleId,
  }) async {
    _setLoading(true);

    final result = await repository.getCollaborators();

    result.fold(
      (failure) => _collaborators = [],
      (list) {
        _collaborators = list
            .where((c) => c.fullName.toLowerCase().contains(name.toLowerCase()))
            .toList();
      },
    );

    _setLoading(false);
  }

  void orderByAlphabetic({
    required List<CollaboratorEntity> list,
    required bool isAscending,
  }) {
    _collaborators = [...list]..sort((a, b) {
        final nameA = a.fullName.toLowerCase();
        final nameB = b.fullName.toLowerCase();
        return isAscending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
      });
    notifyListeners();
  }

  void orderByCreatedTime({
    required List<CollaboratorEntity> list,
    required bool isAscending,
  }) {
    _collaborators = [...list]..sort((a, b) {
        return isAscending
            ? a.createdAt.compareTo(b.createdAt)
            : b.createdAt.compareTo(a.createdAt);
      });
    notifyListeners();
  }

  void orderByStatus({
    required List<CollaboratorEntity> list,
    required bool isAscending,
  }) {
    _collaborators = [...list]..sort((a, b) {
        return isAscending
            ? a.isActive.toString().compareTo(b.isActive.toString())
            : b.isActive.toString().compareTo(a.isActive.toString());
      });
    notifyListeners();
  }
}
