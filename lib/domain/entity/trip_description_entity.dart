class TripDescriptionEntity {
  final String tripId;
  final String airportOrigin;
  final String airportDestination;

  TripDescriptionEntity({
    required this.tripId,
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

  factory TripDescriptionEntity.fromMap(Map<String, dynamic> map) {
    return TripDescriptionEntity(
      tripId: map['tripId'] ?? '',
      airportOrigin: map['airportOrigin'] ?? '',
      airportDestination: map['airportDestination'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tripId': tripId,
      'airportOrigin': airportOrigin,
      'airportDestination': airportDestination,
    };
  }
}

