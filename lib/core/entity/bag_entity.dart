import 'package:uuid/uuid.dart';
import '../enums/bag_status_enum.dart';

class BagEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String? description;
  final String ownerId;
  final BagStatusEnum status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  BagEntity({
    String? id,
    required this.ownerId,
    required this.description,
    required this.status,
    DateTime? createdAt,
    this.updatedAt,
  })  : id = id ?? _uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  BagEntity copyWith({
    String? id,
    String? description,
    BagStatusEnum? status,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BagEntity(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory BagEntity.empty() {
    return BagEntity(
      id: '',
      ownerId: '',
      description: '',
      status: BagStatusEnum.UNKNOWN,
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'ownerId': ownerId,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }
}
