import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';

class BagEntity {
  final String id;
  final String ownerId;
  final String description;
  final BagStatusEnum status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  BagEntity({
    required this.ownerId,
    required this.description,
    required this.status,
    DateTime? createdAt,
    this.updatedAt,
    required String id,
  })  : id = id ,
        createdAt = createdAt ?? DateTime.now();

  factory BagEntity.empty() {
    return BagEntity(
      id:'',
      ownerId: '',
      description: '',
      status: BagStatusEnum.CHECKED_IN,
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }

  factory BagEntity.fromMap(Map<String, dynamic> map, {String? id}) {
    return BagEntity(
      id: id ?? map['id'] ?? '',
      ownerId: map['ownerId'] ?? '',
      description: map['description'] ?? '',
      status: BagStatusEnum.values.byName(map['status']),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
    );
  }

  BagEntity copyWith({
    String? id,
    String? ownerId,
    String? description,
    BagStatusEnum? status,
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

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'description': description,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
