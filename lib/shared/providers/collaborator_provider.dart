import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/failures/failure.dart';
import '../../infra/repositories/collaborator_repository_impl.dart';

class CollaboratorProvider extends ChangeNotifier {
  final CollaboratorRepositoryImpl repository;

  CollaboratorProvider(this.repository);

  bool _isLoading = false;
  List<CollaboratorEntity>? _collaborators;
  List<TripEntity>? _trips;

  bool get isLoading => _isLoading;
  List<CollaboratorEntity>? get collaborators => _collaborators;
  List<TripEntity>? get trips => _trips;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getCollaboratorsByResponsibleId(String id) async {
    _setLoading(true);
    final result = await repository.getCollaboratorsByResponsibleId(id: id);
    result.fold(
      (failure) => _collaborators = [],
      (list) => _collaborators = list,
    );
    _setLoading(false);
  }

  Future<void> getAllTripsByResponsible({required String responsibleId}) async {
    _setLoading(true);

    final result = await repository.getCollaboratorTripsByCollaboratorId(
      collaboratorId: responsibleId,
    );

    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );

    _setLoading(false);
  }
}
