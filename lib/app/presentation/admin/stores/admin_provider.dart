import 'package:tcc_bag_finder/app/data/datasources/bag_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/trip_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/user_local_datasource.dart';
import 'package:tcc_bag_finder/app/events/user_deleted_event.dart';
import 'package:tcc_bag_finder/app/events/user_updated_event.dart';
import 'package:tcc_bag_finder/app/presentation/admin/stores/handlers/admin_provider_handler.dart';
import 'package:tcc_bag_finder/app/shared/helpers/functions/order_alphabetic_function.dart';
import 'package:tcc_bag_finder/app/shared/helpers/functions/order_by_created_time_function.dart';
import 'package:tcc_bag_finder/app/shared/helpers/functions/order_by_status_function.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/usecases/collaborator/get_collaborators_by_responsible_id_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_all_trip_by_company_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/get_users_by_name_usecase.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AdminProvider extends ChangeNotifier {
  final ITripLocalDatasource _tripLocalDatasource;
  final IUserLocalDatasource _userLocalDatasource;
  final IBagLocalDatasource _bagLocalDatasource;

  List<CollaboratorEntity>? _collaborators;
  List<TripEntity>? _collaboratorTrips;
  final IGetCollaboratorsByResponsibleIdUsecase
      _getCollaboratorsByResponsibleIdUsecase;
  final IGetUsersByNameUsecase _getUsersByNameUsecase;
  final IGetAllTripsByResponsibleIdUsecase _getAllTripsByResponsibleIdUsecase;

  final EventBus _eventBus = Modular.get<EventBus>();
  late final CollaboratorEventHandler _eventHandler;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AdminProvider(
    this._getCollaboratorsByResponsibleIdUsecase,
    this._getUsersByNameUsecase,
    this._getAllTripsByResponsibleIdUsecase,
    this._userLocalDatasource,
    this._tripLocalDatasource,
    this._bagLocalDatasource,
  ) {
    _eventHandler = CollaboratorEventHandler(
      onRemoveById: _removeCollaboratorById,
      onUpdate: _updateCollaborator,
    );

    _eventBus.on<UserDeletedEvent>().listen(
          _eventHandler.handleUserDeleted,
        );
    _eventBus.on<UserUpdatedEvent>().listen(
          _eventHandler.handleUserUpdated,
        );
  }

  List<CollaboratorEntity>? get collaborators => _collaborators;

  List<TripEntity>? get collaboratorTrips => _collaboratorTrips;
  void _removeCollaboratorById(
    String id,
  ) {
    _collaborators?.removeWhere(
      (element) => element.id == id,
    );
    notifyListeners();
  }

  void _updateCollaborator(
    CollaboratorEntity updatedCollaborator,
  ) {
    final index = _collaborators?.indexWhere(
      (element) => element.id == updatedCollaborator.id,
    );
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

    var result = await _getCollaboratorsByResponsibleIdUsecase.call(
      id: id,
    );

    result.fold(
      (l) {
        _collaborators = null;
        GlobalSnackBar.error(
          l.errorMessage,
        );
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

    var result = await _getAllTripsByResponsibleIdUsecase.call(
      responsibleCollaboratorId: collaboratorId,
    );

    result.fold(
      (l) {
        _collaboratorTrips = null;
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) {
        _collaboratorTrips = r;
      },
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

    var result = await _getUsersByNameUsecase.call(
      name: name,
    );

    result.fold(
      (l) {
        _collaborators = null;
        GlobalSnackBar.error(
          l.errorMessage,
        );
      },
      (r) {
        _collaborators = r
            .cast<CollaboratorEntity>()
            .where(
              (u) => u.responsibleId == responsibleId,
            )
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
