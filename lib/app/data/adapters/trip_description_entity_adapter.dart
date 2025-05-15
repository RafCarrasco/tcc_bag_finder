import 'package:tcc_bag_finder/domain/entity/trip_description_entity.dart';

class TripDescriptionEntityAdapter {
  static TripDescriptionEntity fromJson(Map<String, dynamic> json) {
    return TripDescriptionEntity(
      tripId: json['tripId'] as String,
      airportOrigin: json['airportOrigin'] as String,
      airportDestination: json['airportDestination'] as String,
    );
  }

  static Map<String, dynamic> toJson(TripDescriptionEntity tripDescription) {
    return {
      'tripId': tripDescription.tripId,
      'airportOrigin': tripDescription.airportOrigin,
      'airportDestination': tripDescription.airportDestination,
    };
  }
}
