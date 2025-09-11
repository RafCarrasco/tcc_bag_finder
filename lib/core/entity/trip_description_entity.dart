class TripDescriptionEntity {
  final String tripId;
  final String airportOrigin;
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

  Map<String, dynamic> toJson() {
    return {
      'tripId': tripId,
      'airportOrigin': airportOrigin,
      'airportDestination': airportDestination,
    };
  }

  factory TripDescriptionEntity.fromJson(Map<String, dynamic> json) {
    return TripDescriptionEntity(
      tripId: json['tripId'] ?? '',
      airportOrigin: json['airportOrigin'] ?? '',
      airportDestination: json['airportDestination'] ?? '',
    );
  }
}
