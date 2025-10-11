import 'package:uuid/uuid.dart';

class BagStatusEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String bagId;
  final String status;
  final DateTime createdAt;
  final String? destination;
  final String? rfidTag;
  final String? printedCode;
  final String? flightConnection;
  final bool isFinalDestination;

  BagStatusEntity({
    String? id,
    required this.bagId,
    required this.status,
    DateTime? createdAt,
    this.destination,
    this.rfidTag,
    this.printedCode,
    this.flightConnection,
    this.isFinalDestination = false,
  })  : id = id ?? _uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  BagStatusEntity copyWith({
    String? id,
    String? bagId,
    String? status,
    DateTime? createdAt,
    String? destination,
    String? rfidTag,
    String? printedCode,
    String? flightConnection,
    bool? isFinalDestination,
  }) {
    return BagStatusEntity(
      id: id ?? this.id,
      bagId: bagId ?? this.bagId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      destination: destination ?? this.destination,
      rfidTag: rfidTag ?? this.rfidTag,
      printedCode: printedCode ?? this.printedCode,
      flightConnection: flightConnection ?? this.flightConnection,
      isFinalDestination: isFinalDestination ?? this.isFinalDestination,
    );
  }

  factory BagStatusEntity.empty() {
    return BagStatusEntity(
      bagId: '',
      status: 'CHECKED_IN',
      createdAt: DateTime.now(),
      destination: '',
      rfidTag: '',
      printedCode: '',
      flightConnection: '',
      isFinalDestination: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bag_id': bagId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'destination': destination,
      'rfid_tag': rfidTag,
      'printed_code': printedCode,
      'flight_connection': flightConnection,
      'is_final_destination': isFinalDestination ? 1 : 0,
    };
  }

  factory BagStatusEntity.fromJson(Map<String, dynamic> json) {
    return BagStatusEntity(
      id: json['id'],
      bagId: json['bag_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      destination: json['destination'],
      rfidTag: json['rfid_tag'],
      printedCode: json['printed_code'],
      flightConnection: json['flight_connection'],
      isFinalDestination:
          json['is_final_destination'] == 1 || json['is_final_destination'] == true,
    );
  }
}
