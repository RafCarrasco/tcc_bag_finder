import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/utils/global_snackbar.dart';
import '../../events/trip_created_event.dart';
import '../../usecase/trip/add_trip_usecase.dart';
import '../entity/trip_entity.dart';
import 'package:event_bus/event_bus.dart';

class TripProvider extends ChangeNotifier {
  final IAddTripUsecase _addTripUsecase;
  final EventBus _eventBus = Modular.get<EventBus>();

  TripProvider(this._addTripUsecase);

  Future<TripEntity?> addTrip({required TripEntity trip}) async {
    final result = await _addTripUsecase.call(trip: trip);

    result.fold(
      (l) {
        GlobalSnackBar.error(l.errorMessage);
      },
      (r) {
        _eventBus.fire(TripCreatedEvent(trip: r));
        GlobalSnackBar.success('Viagem criada com sucesso!');
      },
    );

    notifyListeners();
    return trip;
  }
}
