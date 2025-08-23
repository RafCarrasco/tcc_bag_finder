import 'package:flutter/foundation.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/entity/bag_entity.dart';
import '../../repositories/trip_repository.dart';

class TravelerProvider extends ChangeNotifier {
  final ITripRepository repository;

  TravelerProvider(this.repository);

  TripEntity? _currentTrip;
  List<BagEntity>? _bags;
  List<TripEntity>? _trips;
  bool _isLoading = false;

  TripEntity? get currentTrip => _currentTrip;
  List<BagEntity>? get bags => _bags;
  List<TripEntity>? get trips => _trips;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getTripsByStatus({
    required String travelerId,
    required bool isDone,
  }) async {
    _setLoading(true);

    final result = await repository.getTripsByStatusAndId(
      travelerId: travelerId,
      isDone: isDone,
    );

    result.fold(
      (failure) {
        _currentTrip = null;
        _bags = [];
        _trips = [];
      },
      (trips) {
        _trips = trips;
        if (trips.isNotEmpty) {
          _currentTrip = trips.first;
          _bags = _currentTrip?.bags ?? [];
        } else {
          _currentTrip = null;
          _bags = [];
        }
      },
    );

    _setLoading(false);
  }
}
