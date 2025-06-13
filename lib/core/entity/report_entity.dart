import 'package:uuid/uuid.dart';
import 'bag_entity.dart';

class ReportEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String description;
  final String userId; // Apenas o ID do usuário
  final BagEntity bagEntity;

  ReportEntity({
    String? id,
    required this.description,
    required this.userId,
    required this.bagEntity,
  }) : id = id ?? _uuid.v4();

  ReportEntity copyWith({
    String? id,
    String? description,
    String? userId,
    BagEntity? bagEntity,
  }) {
    return ReportEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      bagEntity: bagEntity ?? this.bagEntity,
    );
  }

  factory ReportEntity.empty() {
    return ReportEntity(
      id: '',
      description: '',
      userId: '',
      bagEntity: BagEntity.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'userId': userId,
      'bagEntity': bagEntity.toJson(),
    };
  }

  factory ReportEntity.fromJson(Map<String, dynamic> json) {
    return ReportEntity(
      id: json['id'],
      description: json['description'],
      userId: json['userId'],
      bagEntity: BagEntity.fromJson(json['bagEntity']),
    );
  }
}
