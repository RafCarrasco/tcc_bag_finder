import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/entity/trip_history_entity.dart';
import '../../repositories/trip_repository.dart';

class TravelerProvider extends ChangeNotifier {
  final ITripRepository repository;

  TravelerProvider(this.repository);

  TripEntity? _currentTrip;
  List<BagEntity>? _bags;
  List<TripEntity>? _trips;
  List<TripHistoryEntity> _history = [];
  bool _isLoading = false;
  bool _isTripComplete = false;
  int _checkedBags = 0;
  Timer? _pollingTimer;

  TripEntity? get currentTrip => _currentTrip;
  List<BagEntity>? get bags => _bags;
  List<TripEntity>? get trips => _trips;
  List<TripHistoryEntity> get history => _history;
  bool get isLoading => _isLoading;
  bool get isTripComplete => _isTripComplete;
  int get checkedBags => _checkedBags;

  void _setLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getTravelerHistory(String travelerId) async {
    _setLoading(true);
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/bags/traveler/$travelerId/history'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _history = data.map((e) => TripHistoryEntity.fromJson(e)).toList();
      } else {
        _history = [];
      }
    } catch (e) {
      _history = [];
    }
    _setLoading(false);
  }

Future<void> getTripsByStatus({
  required String travelerId,
  required bool isDone,
}) async {
  print("Buscando viagens para o viajante $travelerId (isDone=$isDone)");

  _setLoading(true);

  final result = await repository.getTripsByStatusAndId(
    travelerId: travelerId,
    isDone: isDone,
  );

  result.fold(
    (failure) {
      print("Falha ao buscar viagens: $failure");
      _currentTrip = null;
      _bags = [];
      _trips = [];
    },
    (trips) {
      print("Viagens recebidas: ${trips.length}");
      if (trips.isNotEmpty) {
        print("Primeira viagem: ${trips.first.id}");
        _currentTrip = trips.first;
        _bags = _currentTrip?.bags ?? [];
        _startPolling(travelerId);
      } else {
        print("Nenhuma viagem encontrada");
        _currentTrip = null;
        _bags = [];
        _stopPolling();
      }
    },
  );

  _setLoading(false);
}


  Future<void> getTripsById({required String tripId}) async {
    _setLoading(true);
    final result = await repository.getTripsById(tripId: tripId);
    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );
    _setLoading(false);
  }

  Future<void> checkIsTripDone({required TripEntity trip}) async {
    final result = await repository.isTripDone(tripId: trip.id);
    result.fold(
      (_) => _isTripComplete = false,
      (isDone) => _isTripComplete = isDone,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void updateCheckedBags(int value) {
    _checkedBags = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void checkTripCompletion() {
    if (_bags != null && _checkedBags >= _bags!.length) {
      _isTripComplete = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void orderTripsByCreatedTime({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = [...list]..sort((a, b) {
        return isAscending
            ? a.createdAt.compareTo(b.createdAt)
            : b.createdAt.compareTo(a.createdAt);
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void orderTripsByUpdatedTime({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = [...list]..sort((a, b) {
        return isAscending
            ? (a.updatedAt ?? DateTime(0)).compareTo(b.updatedAt ?? DateTime(0))
            : (b.updatedAt ?? DateTime(0))
                .compareTo(a.updatedAt ?? DateTime(0));
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> updateBag({required BagEntity bag}) async {
    _setLoading(true);
    final result = await repository.updateBag(bag: bag);
    result.fold(
      (failure) {},
      (_) {
        if (_bags != null) {
          final index = _bags!.indexWhere((b) => b.id == bag.id);
          if (index != -1) {
            _bags![index] = bag;
          }
        }
      },
    );
    _setLoading(false);
  }

  void orderBagsByUpdatedTime({
    required List<BagEntity> list,
    required bool isAscending,
  }) {
    _bags = [...list]..sort((a, b) {
        return isAscending
            ? (a.updatedAt ?? DateTime(0)).compareTo(b.updatedAt ?? DateTime(0))
            : (b.updatedAt ?? DateTime(0))
                .compareTo(a.updatedAt ?? DateTime(0));
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void orderBagsByStatus({
    required List<BagEntity> list,
    required bool isAscending,
  }) {
    _bags = [...list]..sort((a, b) {
        final aStatus = a.status.toString();
        final bStatus = b.status.toString();
        return isAscending
            ? aStatus.compareTo(bStatus)
            : bStatus.compareTo(aStatus);
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getCurrentTripBagsById({
    required TripEntity trip,
    required String bagId,
  }) async {
    _setLoading(true);
    final result =
        await repository.getCurrentTripBagsById(trip: trip, bagId: bagId);
    result.fold(
      (failure) => _bags = [],
      (list) => _bags = list,
    );
    _setLoading(false);
  }

  void _startPolling(String travelerId) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      try {
        final result = await repository.getTripsByStatusAndId(
          travelerId: travelerId,
          isDone: false,
        );

        result.fold(
          (failure) {},
          (trips) {
            if (trips.isNotEmpty) {
              final updatedTrip = trips.first;
              final updatedBags = updatedTrip.bags ?? [];

              if (!listEquals(_bags, updatedBags)) {
                _bags = updatedBags;
                _currentTrip = updatedTrip;
                notifyListeners();
              }
            }
          },
        );
      } catch (e) {
        if (kDebugMode) print('Polling error: $e');
      }
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  @override
  void dispose() {
    _stopPolling();
    super.dispose();
  }
}
