import 'package:uuid/uuid.dart';
import 'trip_description_entity.dart';
import 'bag_entity.dart';
import 'traveler_entity.dart';

class TripEntity {
  final String id;
  final String responsibleCollaboratorId;
  final TripDescriptionEntity description;
  final bool isDone;
  final List<BagEntity> bags;
  final TravelerEntity travelerEntity;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TripEntity({
    required this.responsibleCollaboratorId,
    required this.description,
    required this.isDone,
    required this.bags,
    required this.travelerEntity,
    required this.createdAt,
    this.updatedAt,
    String? id,
  }) : id = id ?? const Uuid().v4();

factory TripEntity.fromMap(
  Map<String, dynamic> map, {
  String? id,
  List<BagEntity>? bags,
}) {
  return TripEntity(
    id: id,
    responsibleCollaboratorId: map['responsibleCollaboratorId'] ?? '',
    description: TripDescriptionEntity.fromMap(map['description']),
    isDone: map['isDone'] ?? false,
    bags: bags ??
        ((map['bags'] as Map<String, dynamic>? ?? {})
            .values
            .map((e) => BagEntity.fromMap(e as Map<String, dynamic>))
            .toList()),
    travelerEntity: TravelerEntity.fromMap(map['travelerEntity'] ?? <String, dynamic>{}),
    createdAt: DateTime.parse(map['createdAt']),
    updatedAt: map['updatedAt'] != null
        ? DateTime.parse(map['updatedAt'])
        : null,
  );
}


  Map<String, dynamic> toMap() {
    return {
      'responsibleCollaboratorId': responsibleCollaboratorId,
      'description': description.toMap(),
      'isDone': isDone,
      'bags': bags.map((e) => e.toMap()).toList(),
      'travelerEntity': travelerEntity.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory TripEntity.empty() {
    return TripEntity(
      responsibleCollaboratorId: '',
      description: TripDescriptionEntity.empty(),
      isDone: false,
      bags: [],
      travelerEntity: TravelerEntity.empty(),
      createdAt: DateTime.now(),
    );
  }

  TripEntity copyWith({
    String? responsibleCollaboratorId,
    TripDescriptionEntity? description,
    bool? isDone,
    List<BagEntity>? bags,
    TravelerEntity? travelerEntity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TripEntity(
      id: id,
      responsibleCollaboratorId:
          responsibleCollaboratorId ?? this.responsibleCollaboratorId,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      bags: bags ?? this.bags,
      travelerEntity: travelerEntity ?? this.travelerEntity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
