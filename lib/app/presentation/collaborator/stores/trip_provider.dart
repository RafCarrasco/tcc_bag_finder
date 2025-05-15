import 'package:tcc_bag_finder/app/data/datasources/bag_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/trip_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/user_local_datasource.dart';
import 'package:tcc_bag_finder/app/events/trip_created_event.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/add_trip_usecase.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TripProvider extends ChangeNotifier {
  final IAddTripUsecase _addTripUsecase;
  final EventBus _eventBus = Modular.get<EventBus>();

  TripProvider(
    this._addTripUsecase,
  );

  Future<TripEntity?> addTrip({
    required TripEntity trip,
  }) async {
    var result = await _addTripUsecase.call(
      trip: trip,
    );

    result.fold(
      (l) {
        GlobalSnackBar.error(
          l.errorMessage,
        );
      },
      (r) {
        _eventBus.fire(
          TripCreatedEvent(
            trip: r,
          ),
        );

        GlobalSnackBar.success(
          'Viagem criada com sucesso!',
        );
      },
    );
    notifyListeners();

    return trip;
  }
}
