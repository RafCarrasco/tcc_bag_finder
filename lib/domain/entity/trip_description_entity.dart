import 'package:hive/hive.dart';

part 'trip_description_entity.g.dart';

@HiveType(typeId: 6)
class TripDescriptionEntity {
  @HiveField(0)
  String tripId;

  @HiveField(1)
  final String airportOrigin;
  
  @HiveField(2)
  final String airportDestination;

  TripDescriptionEntity({
    this.tripId = '',
    required this.airportOrigin,
    required this.airportDestination,
  });

  TripDescriptionEntity copyWith({
    String? tripId,
    String? airportOrigin,
    String? airportDestination,
  }) {
    return TripDescriptionEntity(
      tripId: tripId ?? this.tripId,
      airportOrigin: airportOrigin ?? this.airportOrigin,
      airportDestination: airportDestination ?? this.airportDestination,
    );
  }

  factory TripDescriptionEntity.empty() {
    return TripDescriptionEntity(
      tripId: '',
      airportOrigin: '',
      airportDestination: '',
    );
  }
}
