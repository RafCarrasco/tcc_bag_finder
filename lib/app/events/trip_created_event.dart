import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';

class TripCreatedEvent {
  final TripEntity trip;

  TripCreatedEvent({
    required this.trip,
  });
}
