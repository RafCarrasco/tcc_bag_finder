import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/utils/global_snackbar.dart';
import '../../events/trip_created_event.dart';
import '../../functions/order_alphabetic_function.dart';
import '../../functions/order_by_created_time_function.dart';
import '../../functions/order_by_status_function.dart';
import '../../usecase/bag/add_bag_usecase.dart';
import '../../usecase/get_all_traveler_usecase.dart';
import '../../usecase/trip/get_all_trip_by_company_usecase.dart';
import '../../usecase/trip/get_all_trip_by_traveler_usecase.dart';
import '../entity/bag_entity.dart';
import '../entity/collaborator_provider_handler.dart';
import '../entity/trip_entity.dart';
import '../entity/traveler_entity.dart';
import 'package:event_bus/event_bus.dart';

class CollaboratorProvider extends ChangeNotifier {
  final IAddBagUsecase _addBagUsecase;
  final IGetAllTravelerUsecase _getAllTravelerUsecase;
  final IGetAllTripsByResponsibleIdUsecase _getAllTripsByResponsibleIdUsecase;
  final IGetAllTripsByTravelerIdUsecase _getAllTripsByTravelerIdUsecase;

  final EventBus _eventBus = Modular.get<EventBus>();
  late final TripEventHandler _eventHandler;

  List<TravelerEntity>? _travelers;
  List<TripEntity>? _trips;
  bool _isLoading = false;

  CollaboratorProvider(
    this._addBagUsecase,
    this._getAllTravelerUsecase,
    this._getAllTripsByResponsibleIdUsecase,
    this._getAllTripsByTravelerIdUsecase,
  ) {
    _eventHandler = TripEventHandler(
      onAdd: _addTrip,
    );

    _eventBus.on<TripCreatedEvent>().listen(_eventHandler.handleTripCreated);
  }

  bool get isLoading => _isLoading;
  List<TravelerEntity>? get travelers => _travelers;
  List<TripEntity>? get trips => _trips;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _addTrip(TripEntity trip) {
    _trips ??= [];
    _trips!.add(trip);
    notifyListeners();
  }

  Future<BagEntity> addBag({required BagEntity bag}) async {
    _setLoading(true);
    final result = await _addBagUsecase.call(bag: bag);
    _setLoading(false);

    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) {},
    );

    return bag;
  }

  Future<List<TravelerEntity>> getAllTravelers() async {
    _setLoading(true);
    final result = await _getAllTravelerUsecase.call();
    _setLoading(false);

    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) => _travelers = r,
    );

    notifyListeners();
    return _travelers ?? [];
  }

  Future<List<TripEntity>> getAllTripsByResponsible({
    required String responsibleId,
  }) async {
    _setLoading(true);
    final result = await _getAllTripsByResponsibleIdUsecase.call(
      responsibleCollaboratorId: responsibleId,
    );
    _setLoading(false);

    result.fold(
      (l) {
        _trips = null;
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) => _trips = r,
    );

    notifyListeners();
    return _trips ?? [];
  }

  Future<List<TripEntity>> getAllTripsByTraveler({
    required String travelerId,
  }) async {
    _setLoading(true);
    final result = await _getAllTripsByTravelerIdUsecase.call(
      travelerId: travelerId,
    );
    _setLoading(false);

    result.fold(
      (l) {
        _trips = null;
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) => _trips = r,
    );

    notifyListeners();
    return _trips ?? [];
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
