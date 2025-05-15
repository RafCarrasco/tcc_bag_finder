import 'package:tcc_bag_finder/app/presentation/collaborator/stores/handler/collaborator_provider_handler.dart';
import 'package:tcc_bag_finder/app/shared/helpers/functions/order_alphabetic_function.dart';
import 'package:tcc_bag_finder/app/shared/helpers/functions/order_by_created_time_function.dart';
import 'package:tcc_bag_finder/app/shared/helpers/functions/order_by_status_function.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:tcc_bag_finder/domain/usecases/bag/get_bag_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/bag/get_current_trip_bags_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/bag/update_bag_usecacse.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/check_done_trip_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_all_trip_by_traveler_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_trips_by_id_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_trips_by_status_and_id_usecase.dart';
import 'package:flutter/material.dart';

class TravelerProvider extends ChangeNotifier {
  List<TripEntity>? _trips;
  TripEntity? _currentTrip;
  List<BagEntity>? _bags;
  final IGetAllTripsByTravelerIdUsecase _getAllTripsByTravelerUsecase;
  final ICheckDoneTripUsecase _checkDoneTripUsecase;
  final IGetTripsByIdUsecase _getTripsByIdUsecase;
  final IGetCurrentTripBagsByIdUsecase _getCurrentTripBagsByIdUsecase;
  final IGetBagsByIdUsecase _getBagsByIdUsecase;
  final IUpdateBagUsecase _updateBagStatusUsecase;
  final IGetTripsByStatusAndIdUsecase _getTripsByStatusAndIdUsecase;
  late final TripEventHandler _eventHandler;

  bool _isLoading = false;
  bool _isTripComplete = false;

  TravelerProvider(
    this._getAllTripsByTravelerUsecase,
    this._getBagsByIdUsecase,
    this._getCurrentTripBagsByIdUsecase,
    this._getTripsByIdUsecase,
    this._getTripsByStatusAndIdUsecase,
    this._updateBagStatusUsecase,
    this._checkDoneTripUsecase,
  ) {
    _eventHandler = TripEventHandler(
      onAdd: _initTrip,
    );
  }

  bool get isLoading => _isLoading;
  bool get isTripComplete => _isTripComplete;
  int get checkedBags => _bags != null
      ? _bags!.where((e) => e.status == BagStatusEnum.CLAIMED).length
      : 0;

  List<TripEntity>? get trips => _trips;
  List<BagEntity>? get bags => _bags;
  TripEntity? get currentTrip => _currentTrip;

  void checkTripCompletion() {
    _isTripComplete = _bags != null &&
        _bags!.every((bag) => bag.status == BagStatusEnum.CLAIMED);
  }

  void _initTrip(TripEntity trip) {
    _currentTrip = trip;
    notifyListeners();
  }

  void finishTrip() {
    _currentTrip = null;
    notifyListeners();
  }

  Future<List<TripEntity>> getAllTripsByResponsibleId({
    required String travelerId,
  }) async {
    _isLoading = true;
    notifyListeners();
    var result =
        await _getAllTripsByTravelerUsecase.call(travelerId: travelerId);

    result.fold(
      (l) {
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) {
        _trips = r;
      },
    );

    _isLoading = false;
    notifyListeners();
    return _trips ?? [];
  }

  Future<void> updateBag({
    required BagEntity bag,
  }) async {
    var result = await _updateBagStatusUsecase.call(
      bag: bag,
    );

    result.fold(
      (l) {
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) {
        _bags = _bags!.map((e) => e.id == bag.id ? bag : e).toList();
        checkTripCompletion();
      },
    );

    notifyListeners();
  }

  Future<TripEntity?> getTripsByStatus({
    required String travelerId,
    required bool? isDone,
  }) async {
    _isLoading = true;
    notifyListeners();

    var result = await _getTripsByStatusAndIdUsecase.call(
      travelerId: travelerId,
      isDone: isDone,
    );

    result.fold(
      (l) {
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) {
        if (isDone != false) {
          _trips = r;
        }

        if (r.isEmpty) {
          print('empty');
          _isLoading = false;
          print(isLoading);

          _currentTrip = null;
          _bags = null;

          notifyListeners();

          return;
        }

        _currentTrip = r.first;
        _bags = r.first.bags;
        checkTripCompletion();
      },
    );

    _isLoading = false;
    notifyListeners();

    return _currentTrip;
  }

  Future<List<BagEntity>> getBagsById({
    required String bagId,
  }) async {
    _isLoading = true;
    notifyListeners();

    var result = await _getBagsByIdUsecase.call(bagId: bagId);

    result.fold(
      (l) {
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) {
        _bags = r;
        checkTripCompletion();
      },
    );

    _isLoading = false;
    notifyListeners();
    return _bags ?? [];
  }

  Future<List<BagEntity>> getCurrentTripBagsById({
    required TripEntity trip,
    required String bagId,
  }) async {
    _isLoading = true;
    notifyListeners();

    var result = await _getCurrentTripBagsByIdUsecase.call(
      bagId: bagId,
      trip: trip,
    );

    result.fold(
      (l) {
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) {
        _bags = r;
        checkTripCompletion();
      },
    );

    _isLoading = false;
    notifyListeners();
    return _bags ?? [];
  }

  Future<bool> checkIsTripDone({
    required TripEntity trip,
  }) async {
    var result = await _checkDoneTripUsecase.call(trip: trip);

    return result.fold(
      (l) {
        return false;
      },
      (r) {
        return r;
      },
    );
  }

  Future<List<TripEntity>> getTripsById({
    required String tripId,
  }) async {
    _isLoading = true;
    notifyListeners();

    var result = await _getTripsByIdUsecase.call(tripId: tripId);

    result.fold(
      (l) {
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) {
        _trips = r;
      },
    );

    _isLoading = false;
    notifyListeners();
    return _trips ?? [];
  }

  void orderBagsByUpdatedTime({
    required List<BagEntity> list,
    required bool isAscending,
  }) {
    _bags = orderBagsByUpdatedTimeFunction(
      list: list,
      isAscending: isAscending,
    ).cast<BagEntity>();
    notifyListeners();
  }

  void orderBagsByDoneStatus({
    required List<BagEntity> list,
    required bool isAscending,
  }) {
    _bags = orderBagsByUpdatedTimeFunction(
      list: list,
      isAscending: isAscending,
    ).cast<BagEntity>();
    notifyListeners();
  }

  void orderBagsByStatus({
    required List<BagEntity> list,
    required bool isAscending,
  }) {
    _bags = orderBagsByStatusFunction(
      list: list,
      isAscending: isAscending,
    ).cast<BagEntity>();
    notifyListeners();
  }

  void orderBagsAlphabetic({
    required List<BagEntity> list,
    required bool isAscending,
  }) {
    _bags = orderBagsAlphabeticFunction(
      list: list,
      isAscending: isAscending,
    ).cast<BagEntity>();
    notifyListeners();
  }

  void orderTripsByUpdatedTime({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = orderTripsByUpdatedTimeFunction(
      list: list,
      isAscending: isAscending,
    );
    notifyListeners();
  }

  void orderTripsByCreatedTime({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = orderTripsByCreatedTimeFunction(
      list: list,
      isAscending: isAscending,
    ).cast<TripEntity>();
    notifyListeners();
  }
}
