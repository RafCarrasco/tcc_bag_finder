import 'package:tcc_bag_finder/app/data/datasources/bag_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/trip_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/user_local_datasource.dart';
import 'package:tcc_bag_finder/app/events/trip_created_event.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/stores/handler/collaborator_provider_handler.dart';
import 'package:tcc_bag_finder/app/shared/helpers/functions/order_alphabetic_function.dart';
import 'package:tcc_bag_finder/app/shared/helpers/functions/order_by_created_time_function.dart';
import 'package:tcc_bag_finder/app/shared/helpers/functions/order_by_status_function.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/usecases/bag/add_bag_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/traveler/get_all_traveler_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_all_trip_by_company_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_all_trip_by_traveler_usecase.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CollaboratorProvider extends ChangeNotifier {
  List<TravelerEntity>? _travelers;
  List<TripEntity>? _trips;
  final IAddBagUsecase _addBagUsecase;
  final IGetAllTripsByTravelerIdUsecase _getAllTripsByTravelerIdUsecase;
  final IGetAllTravelerUsecase _getAllTravelerUsecase;
  final IGetAllTripsByResponsibleIdUsecase _getAllTripsByResponsibleIdUsecase;
  final EventBus _eventBus = Modular.get<EventBus>();
  late final TripEventHandler _eventHandler;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CollaboratorProvider(
    this._addBagUsecase,
    this._getAllTravelerUsecase,
    this._getAllTripsByResponsibleIdUsecase,
    this._getAllTripsByTravelerIdUsecase,
  ) {
    _eventHandler = TripEventHandler(
      onAdd: _addTrip,
    );

    _eventBus.on<TripCreatedEvent>().listen(
          _eventHandler.handleTripCreated,
        );
  }

  List<TravelerEntity>? get travelers => _travelers;
  List<TripEntity>? get trips => _trips;

  void _addTrip(
    TripEntity trip,
  ) {
    _trips ??= [];
    _trips!.add(
      trip,
    );
    
    notifyListeners();
  }

  Future<BagEntity> addBag({
    required BagEntity bag,
  }) async {
    _setLoading(true);
    var result = await _addBagUsecase.call(bag: bag);
    _setLoading(false);

    result.fold(
      (l) {
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) => r,
    );

    return bag;
  }

  Future<List<TravelerEntity>> getAllTravelers() async {
    _setLoading(true);
    var result = await _getAllTravelerUsecase.call();
    _setLoading(false);

    result.fold(
      (l) {
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) => _travelers = r,
    );

    notifyListeners();
    return _travelers ?? [];
  }

  Future<List<TripEntity>> getAllTripsByResponsible({
    required String responsibleId,
  }) async {
    _setLoading(true);
    var result = await _getAllTripsByResponsibleIdUsecase.call(
      responsibleCollaboratorId: responsibleId,
    );

    result.fold(
      (l) {
        _trips = null;
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) => _trips = r,
    );

    _setLoading(false);
    return _trips ?? [];
  }

  Future<List<TripEntity>> getAllTripsByTraveler({
    required String travelerId,
  }) async {
    _setLoading(true);
    var result = await _getAllTripsByTravelerIdUsecase.call(
      travelerId: travelerId,
    );

    result.fold(
      (l) {
        _trips = null;
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) => _trips = r,
    );

    _setLoading(false);
    return _trips ?? [];
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void orderByStatus({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = orderTripsByStatusFunction(
      list: list,
      isAscending: isAscending,
    ).cast<TripEntity>();
    notifyListeners();
  }

  void orderByCreatedTime({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = orderTripsByCreatedTimeFunction(
      list: list,
      isAscending: isAscending,
    ).cast<TripEntity>();
    notifyListeners();
  }

  void orderByAlphabetic({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = orderTripsAlphabeticFunction(
      list: list,
      isAscending: isAscending,
    ).cast<TripEntity>();
    notifyListeners();
  }
}
