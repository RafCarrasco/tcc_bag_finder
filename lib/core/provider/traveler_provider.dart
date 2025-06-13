import 'package:flutter/material.dart';
import '../../functions/order_alphabetic_function.dart';
import '../../functions/order_by_created_time_function.dart';
import '../../functions/order_by_status_function.dart';
import '../../usecase/bag/get_bag_usecase.dart';
import '../../usecase/bag/get_current_trip_bags_usecase.dart';
import '../../usecase/bag/update_bag_usecacse.dart';
import '../../usecase/trip/check_done_trip_usecase.dart';
import '../../usecase/trip/get_all_trip_by_traveler_usecase.dart';
import '../../usecase/trip/get_trips_by_id_usecase.dart';
import '../../usecase/trip/get_trips_by_status_and_id_usecase.dart';
import '../entity/bag_entity.dart';
import '../entity/trip_entity.dart';
import '../enums/bag_status_enum.dart';
import '../utils/global_snackbar.dart';

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
  );

  bool get isLoading => _isLoading;
  bool get isTripComplete => _isTripComplete;
  int get checkedBags => _bags?.where((e) => e.status == BagStatusEnum.CLAIMED).length ?? 0;

  List<TripEntity>? get trips => _trips;
  List<BagEntity>? get bags => _bags;
  TripEntity? get currentTrip => _currentTrip;

  void checkTripCompletion() {
    _isTripComplete = _bags != null && _bags!.every((bag) => bag.status == BagStatusEnum.CLAIMED);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void finishTrip() {
    _currentTrip = null;
    notifyListeners();
  }

  Future<List<TripEntity>> getAllTripsByTravelerId({
    required String travelerId,
  }) async {
    _setLoading(true);
    final result = await _getAllTripsByTravelerUsecase.call(travelerId: travelerId);
    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) => _trips = r,
    );
    _setLoading(false);
    return _trips ?? [];
  }

  Future<void> updateBag({required BagEntity bag}) async {
    final result = await _updateBagStatusUsecase.call(bag: bag);
    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) {
        _bags = _bags?.map((e) => e.id == bag.id ? bag : e).toList();
        checkTripCompletion();
      },
    );
    notifyListeners();
  }

  Future<TripEntity?> getTripsByStatus({
    required String travelerId,
    required bool? isDone,
  }) async {
    _setLoading(true);
    final result = await _getTripsByStatusAndIdUsecase.call(travelerId: travelerId, isDone: isDone);
    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) {
        if (isDone != false) _trips = r;
        if (r.isNotEmpty) {
          _currentTrip = r.first;
          _bags = r.first.bags;
          checkTripCompletion();
        } else {
          _currentTrip = null;
          _bags = null;
        }
      },
    );
    _setLoading(false);
    return _currentTrip;
  }

  Future<List<BagEntity>> getBagsById({required String bagId}) async {
    _setLoading(true);
    final result = await _getBagsByIdUsecase.call(bagId: bagId);
    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) {
        _bags = r;
        checkTripCompletion();
      },
    );
    _setLoading(false);
    return _bags ?? [];
  }

  Future<List<BagEntity>> getCurrentTripBagsById({
    required TripEntity trip,
    required String bagId,
  }) async {
    _setLoading(true);
    final result = await _getCurrentTripBagsByIdUsecase.call(trip: trip, bagId: bagId);
    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) {
        _bags = r;
        checkTripCompletion();
      },
    );
    _setLoading(false);
    return _bags ?? [];
  }

  Future<bool> checkIsTripDone({required TripEntity trip}) async {
    final result = await _checkDoneTripUsecase.call(trip: trip);
    return result.fold((l) => false, (r) => r);
  }

  Future<List<TripEntity>> getTripsById({required String tripId}) async {
    _setLoading(true);
    final result = await _getTripsByIdUsecase.call(tripId: tripId);
    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) => _trips = r,
    );
    _setLoading(false);
    return _trips ?? [];
  }

  // Funções de ordenação
  void orderBagsByUpdatedTime({required List<BagEntity> list, required bool isAscending}) {
    _bags = orderBagsByUpdatedTimeFunction(list: list, isAscending: isAscending).cast<BagEntity>();
    notifyListeners();
  }

  void orderBagsByDoneStatus({required List<BagEntity> list, required bool isAscending}) {
    _bags = orderBagsByUpdatedTimeFunction(list: list, isAscending: isAscending).cast<BagEntity>();
    notifyListeners();
  }

  void orderBagsByStatus({required List<BagEntity> list, required bool isAscending}) {
    _bags = orderBagsByStatusFunction(list: list, isAscending: isAscending).cast<BagEntity>();
    notifyListeners();
  }

  void orderBagsAlphabetic({required List<BagEntity> list, required bool isAscending}) {
    _bags = orderBagsAlphabeticFunction(list: list, isAscending: isAscending).cast<BagEntity>();
    notifyListeners();
  }

  void orderTripsByUpdatedTime({required List<TripEntity> list, required bool isAscending}) {
    _trips = orderTripsByUpdatedTimeFunction(list: list, isAscending: isAscending);
    notifyListeners();
  }

  void orderTripsByCreatedTime({required List<TripEntity> list, required bool isAscending}) {
    _trips = orderTripsByCreatedTimeFunction(list: list, isAscending: isAscending).cast<TripEntity>();
    notifyListeners();
  }
}
