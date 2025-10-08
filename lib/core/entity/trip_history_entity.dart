class TripHistoryEntity {
  final String tripId;
  final String origin;
  final String destination;
  final String bagId;
  final String description;
  final String lastStatus;
  final DateTime statusTime;

  TripHistoryEntity({
    required this.tripId,
    required this.origin,
    required this.destination,
    required this.bagId,
    required this.description,
    required this.lastStatus,
    required this.statusTime,
  });

  factory TripHistoryEntity.fromJson(Map<String, dynamic> json) {
    return TripHistoryEntity(
      tripId: json['trip_id'] ?? '',
      origin: json['origin'] ?? '',
      destination: json['destination'] ?? '',
      bagId: json['bag_id'] ?? '',
      description: json['description'] ?? '',
      lastStatus: json['last_status'] ?? '',
      statusTime: DateTime.tryParse(json['status_time'] ?? '') ?? DateTime.now(),
    );
  }
}