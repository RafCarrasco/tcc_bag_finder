import 'package:uuid/uuid.dart';
import 'bag_entity.dart';
import 'traveler_entity.dart';
import 'trip_description_entity.dart';
import '../../infra/repositories/traveler_repository_impl.dart';

class TripEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String responsibleCollaboratorId;
  final TripDescriptionEntity description;
  final List<BagEntity>? bags;
  final bool isDone;
  final String? cpf;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TripEntity({
    String? id,
    required this.cpf,
    required this.responsibleCollaboratorId,
    required TripDescriptionEntity description,
    required this.bags,
    this.isDone = false,
    DateTime? createdAt,
    this.updatedAt,
  })  : id = id ?? _uuid.v4(),
        description = description.copyWith(tripId: id ?? _uuid.v4()),
        createdAt = createdAt ?? DateTime.now();
  TripEntity copyWith({
    String? id,
    String? cpf,
    String? responsibleCollaboratorId,
    TripDescriptionEntity? description,
    List<BagEntity>? bags,
    bool? isDone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TripEntity(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      responsibleCollaboratorId:
          responsibleCollaboratorId ?? this.responsibleCollaboratorId,
      description: description ?? this.description,
      bags: bags ?? this.bags,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory TripEntity.empty() {
    return TripEntity(
      cpf: '',
      responsibleCollaboratorId: '',
      description: TripDescriptionEntity.empty(),
      bags: [],
      isDone: false,
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpf': cpf,
      'responsibleCollaboratorId': responsibleCollaboratorId,
      'description': description.toJson(),
      'bags': bags?.map((e) => e.toJson()).toList(),
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory TripEntity.fromJson(Map<String, dynamic> json) {
    return TripEntity(
      id: json['id'],
      cpf: json['cpf'],
      responsibleCollaboratorId: json['responsible_collaborator_id'],
      description: TripDescriptionEntity.fromJson(json['description']),
      bags: (json['bags'] as List<dynamic>?)
          ?.map((e) => BagEntity.fromJson(e))
          .toList(),
      isDone: json['isDone'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      
    );
  }
}
