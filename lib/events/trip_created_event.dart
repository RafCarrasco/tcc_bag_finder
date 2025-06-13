import '../core/entity/trip_entity.dart';

class TripCreatedEvent {
  final TripEntity trip;

  TripCreatedEvent({
    required this.trip,
  });
}
