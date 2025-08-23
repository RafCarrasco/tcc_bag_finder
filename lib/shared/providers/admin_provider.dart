import 'package:flutter/foundation.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../infra/repositories/admin_repository_impl.dart';

class AdminProvider extends ChangeNotifier {
  final AdminRepositoryImpl repository;

  AdminProvider(this.repository);

  bool _isLoading = false;
  List<CollaboratorEntity>? _collaborators;
  List<TripEntity>? _collaboratorTrips;

  bool get isLoading => _isLoading;
  List<CollaboratorEntity>? get collaborators => _collaborators;
  List<TripEntity>? get collaboratorTrips => _collaboratorTrips;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Buscar colaboradores de um admin
  Future<void> getCollaboratorsByResponsibleId({required String id}) async {
    _setLoading(true);

    final result = await repository.getCollaboratorsByResponsibleId(id: id);

    result.fold(
      (failure) {
        _collaborators = [];
      },
      (collaborators) {
        _collaborators = collaborators;
      },
    );

    _setLoading(false);
  }

  /// Buscar viagens de um colaborador específico
  Future<void> getCollaboratorTripsByCollaboratorId({required String collaboratorId}) async {
    _setLoading(true);

    final result =
        await repository.getCollaboratorTripsByCollaboratorId(collaboratorId: collaboratorId);

    result.fold(
      (failure) {
        _collaboratorTrips = [];
      },
      (trips) {
        _collaboratorTrips = trips;
      },
    );

    _setLoading(false);
  }
}
