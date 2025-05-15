import 'package:tcc_bag_finder/app/events/trip_created_event.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';

class TripEventHandler {
  final void Function(
    TripEntity,
  ) onAdd;
  TripEventHandler({
    required this.onAdd,
  });

  void handleTripCreated(
    TripCreatedEvent event,
  ) {
    onAdd(
      event.trip,
    );
  }
}
