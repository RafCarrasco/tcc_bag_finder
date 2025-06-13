import '../../events/trip_created_event.dart';
import 'trip_entity.dart';

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
