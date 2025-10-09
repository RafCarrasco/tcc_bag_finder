import 'package:uuid/uuid.dart';
import '../enums/bag_status_enum.dart';

class BagEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String? description;
  final String cpf;
  final BagStatusEnum status;
  final String? tripId;
  final DateTime createdAt;

  BagEntity({
    String? id,
    required this.cpf,
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
    String? cpf,
    String? tripId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BagEntity(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      description: description ?? this.description,
      status: status ?? this.status,
      tripId: tripId ?? this.tripId,
      createdAt: createdAt ?? this.createdAt,
    );
  }


  factory BagEntity.empty() {
    return BagEntity(
      id: '',
      cpf: '',
      description: '',
      status: BagStatusEnum.UNKNOWN,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'cpf': cpf,
      'status': status.name,
      'tripId': tripId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BagEntity.fromJson(Map<String, dynamic> json) {
    return BagEntity(
      id: json['id'],
      description: json['description'],
      cpf: json['cpf'],
      status: BagStatusEnum.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BagStatusEnum.UNKNOWN,
      ),
      tripId: json['tripId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
