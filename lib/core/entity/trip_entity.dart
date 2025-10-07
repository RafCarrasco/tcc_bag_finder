import 'package:uuid/uuid.dart';
import 'bag_entity.dart';
import 'traveler_entity.dart';
import 'trip_description_entity.dart';
import '../../infra/repositories/traveler_repository_impl.dart';

class TripEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final TravelerEntity travelerEntity;
  final String responsibleCollaboratorId;
  final TripDescriptionEntity description;
  final List<BagEntity>? bags;
  final bool isDone;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TripEntity({
    String? id,
    required this.responsibleCollaboratorId,
    TravelerEntity? travelerEntity,
    required TripDescriptionEntity description,
    required this.bags,
    this.isDone = false,
    DateTime? createdAt,
    this.updatedAt,
  })  : id = id ?? _uuid.v4(),
        description = description.copyWith(tripId: id ?? _uuid.v4()),
        travelerEntity = travelerEntity ?? TravelerEntity.empty(),
        createdAt = createdAt ?? DateTime.now();
  TripEntity copyWith({
    String? id,
    String? responsibleCollaboratorId,
    TravelerEntity? travelerEntity,
    TripDescriptionEntity? description,
    List<BagEntity>? bags,
    bool? isDone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TripEntity(
      id: id ?? this.id,
      responsibleCollaboratorId:
          responsibleCollaboratorId ?? this.responsibleCollaboratorId,
      travelerEntity: travelerEntity ?? this.travelerEntity,
      description: description ?? this.description,
      bags: bags ?? this.bags,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory TripEntity.empty() {
    return TripEntity(
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
      'responsibleCollaboratorId': responsibleCollaboratorId,
      'travelerEntity': travelerEntity.toJson(),
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
      responsibleCollaboratorId: json['responsible_collaborator_id'],
      travelerEntity: TravelerEntity.fromJson(json['travelerEntity']),
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
  static Future<TripEntity> fromJsonAsync(
    Map<String, dynamic> json,
    TravelerRepositoryImpl travelerRepository,
  ) async {
    TravelerEntity traveler;

    final travelerData = json['travelerEntity'];

    if (travelerData is String) {
      final result = await travelerRepository.getTravelerById(id: travelerData);
      traveler = result.fold(
        (failure) => TravelerEntity.empty(),
        (entity) => entity ?? TravelerEntity.empty(),
      );
    } else {
      traveler = TravelerEntity.empty();
    }

    return TripEntity(
      id: json['id'],
      responsibleCollaboratorId: json['responsible_collaborator_id'] ?? '',
      travelerEntity: traveler,
      description: TripDescriptionEntity.fromJson(
        json['description'] ?? <String, dynamic>{},
      ),
      bags: (json['bags'] as List<dynamic>?)
          ?.map((e) => BagEntity.fromJson(e))
          .toList(),
      isDone: json['isDone'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? json['created_at'] ?? '') ??
          DateTime.now(),
      updatedAt: json['updatedAt'] != null
                ? DateTime.tryParse(json['updatedAt'])
                : null,
    );
  }

}
