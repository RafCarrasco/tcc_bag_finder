import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../events/user_deleted_event.dart';
import '../../events/user_updated_event.dart';
import '../../functions/order_alphabetic_function.dart';
import '../../functions/order_by_created_time_function.dart';
import '../../functions/order_by_status_function.dart';
import '../../usecase/get_collaborators_by_responsible_id_usecase.dart';
import '../../usecase/get_users_by_name_usecase.dart';
import '../../usecase/trip/get_all_trip_by_company_usecase.dart';
import '../entity/collaborator_entity.dart';
import '../entity/trip_entity.dart';
import 'admin_provider_handler.dart';
import '../../core/utils/global_snackbar.dart';
import 'package:event_bus/event_bus.dart';

class AdminProvider extends ChangeNotifier {
  final IGetCollaboratorsByResponsibleIdUsecase _getCollaboratorsByResponsibleIdUsecase;
  final IGetUsersByNameUsecase _getUsersByNameUsecase;
  final IGetAllTripsByResponsibleIdUsecase _getAllTripsByResponsibleIdUsecase;

  final EventBus _eventBus = Modular.get<EventBus>();
  late final CollaboratorEventHandler _eventHandler;

  List<CollaboratorEntity>? _collaborators;
  List<TripEntity>? _collaboratorTrips;
  bool _isLoading = false;

  AdminProvider(
    this._getCollaboratorsByResponsibleIdUsecase,
    this._getUsersByNameUsecase,
    this._getAllTripsByResponsibleIdUsecase,
  ) {
    _eventHandler = CollaboratorEventHandler(
      onRemoveById: _removeCollaboratorById,
      onUpdate: _updateCollaborator,
    );

    _eventBus.on<UserDeletedEvent>().listen(_eventHandler.handleUserDeleted);
    _eventBus.on<UserUpdatedEvent>().listen(_eventHandler.handleUserUpdated);
  }

  bool get isLoading => _isLoading;
  List<CollaboratorEntity>? get collaborators => _collaborators;
  List<TripEntity>? get collaboratorTrips => _collaboratorTrips;

  void _removeCollaboratorById(String id) {
    _collaborators?.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void _updateCollaborator(CollaboratorEntity updatedCollaborator) {
    final index = _collaborators?.indexWhere((c) => c.id == updatedCollaborator.id);
    if (index != null && index >= 0) {
      _collaborators?[index] = updatedCollaborator;
      notifyListeners();
    }
  }

  Future<List<CollaboratorEntity>> getCollaboratorsByResponsibleId({
    required String id,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _getCollaboratorsByResponsibleIdUsecase.call(id: id);

    result.fold(
      (l) {
        _collaborators = null;
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) => _collaborators = r,
    );

    _isLoading = false;
    notifyListeners();
    return _collaborators ?? [];
  }

  Future<List<TripEntity>> getCollaboratorTripsByCollaboratorId({
    required String collaboratorId,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _getAllTripsByResponsibleIdUsecase.call(
      responsibleCollaboratorId: collaboratorId,
    );

    result.fold(
      (l) {
        _collaboratorTrips = null;
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) => _collaboratorTrips = r,
    );

    _isLoading = false;
    notifyListeners();
    return _collaboratorTrips ?? [];
  }

  Future<List<CollaboratorEntity>> getCollaboratorsByName({
    required String name,
    required String responsibleId,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _getUsersByNameUsecase.call(name: name);

    result.fold(
      (l) {
        _collaborators = null;
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) {
        _collaborators = r
            .whereType<CollaboratorEntity>()
            .where((u) => u.responsibleId == responsibleId)
            .toList();
      },
    );

    _isLoading = false;
    notifyListeners();
    return _collaborators ?? [];
  }

  void orderByStatus({
    required List<CollaboratorEntity> list,
    required bool isAscending,
  }) {
    _collaborators = orderByStatusFunction(
      list: list,
      isAscending: isAscending,
    ).cast<CollaboratorEntity>();
    notifyListeners();
  }

  void orderByCreatedTime({
    required List<CollaboratorEntity> list,
    required bool isAscending,
  }) {
    _collaborators = orderByCreatedTimeFunction(
      list: list,
      isAscending: isAscending,
    ).cast<CollaboratorEntity>();
    notifyListeners();
  }

  void orderByAlphabetic({
    required List<CollaboratorEntity> list,
    required bool isAscending,
  }) {
    _collaborators = orderAlphabeticFunction(
      list: list,
      isAscending: isAscending,
    ).cast<CollaboratorEntity>();
    notifyListeners();
  }
}
