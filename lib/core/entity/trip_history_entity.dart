class TripHistoryEntity {
  final String tripId;
  final String origin;
  final String destination;
  final String bagId;
  final String status;
  final DateTime statusTime;

  TripHistoryEntity({
    required this.tripId,
    required this.origin,
    required this.destination,
    required this.bagId,
    required this.status,
    required this.statusTime,
  });

  factory TripHistoryEntity.fromJson(Map<String, dynamic> json) {
    final isDone = json['is_done'];
    String status;
    if (isDone == 1 || isDone == '1') {
      status = 'DELIVERED';
    } else {
      status = 'CHECKED_IN';
    }
    return TripHistoryEntity(
      tripId: json['id'] ?? '',
      origin: json['origin'] ?? '',
      destination: json['destination'] ?? '',
      bagId: json['bag_id'] ?? '',
      status: status,
      statusTime: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}