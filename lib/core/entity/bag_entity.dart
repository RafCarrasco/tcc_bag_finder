import 'package:uuid/uuid.dart';
import '../enums/bag_status_enum.dart';

class BagEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String? description;
  final String ownerId;
  final BagStatusEnum status;
  final String? tripId;
  final DateTime createdAt;

  BagEntity({
    String? id,
    required this.ownerId,
    required this.description,
    required this.status,
    this.tripId,
    DateTime? createdAt,
  })  : id = id ?? _uuid.v4(),
        createdAt = createdAt ?? DateTime.now();


  BagEntity copyWith({
    String? id,
    String? description,
    BagStatusEnum? status,
    String? ownerId,
    String? tripId, // <-- adicionado
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BagEntity(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      description: description ?? this.description,
      status: status ?? this.status,
      tripId: tripId ?? this.tripId, // <-- adicionado
      createdAt: createdAt ?? this.createdAt,
    );
  }


  factory BagEntity.empty() {
    return BagEntity(
      id: '',
      ownerId: '',
      description: '',
      status: BagStatusEnum.UNKNOWN,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'ownerId': ownerId,
      'status': status.name,
      'tripId': tripId, // <-- adicionado
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BagEntity.fromJson(Map<String, dynamic> json) {
    return BagEntity(
      id: json['id'],
      description: json['description'],
      ownerId: json['ownerId'],
      status: BagStatusEnum.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BagStatusEnum.UNKNOWN,
      ),
      tripId: json['tripId'], // <-- adicionado
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
