import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_description_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'trip_entity.g.dart';

@HiveType(typeId: 7)
class TripEntity {
  static const Uuid _uuid = Uuid();

  @HiveField(0)
  final String id;

  final TravelerEntity travelerEntity;

  @HiveField(1)
  final String responsibleCollaboratorId;

  @HiveField(2)
  final TripDescriptionEntity description;

  @HiveField(3)
  final DateTime time;

  @HiveField(4)
  final List<BagEntity>? bags;

  @HiveField(5)
  final bool isDone;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime? updatedAt;

  TripEntity({
    String? id,
    required this.responsibleCollaboratorId,
    TravelerEntity? travelerEntity,
    required TripDescriptionEntity description,
    required this.bags,
    required this.time,
    this.isDone = false,
    DateTime? createdAt,
    this.updatedAt,
  })  : id = id ?? _uuid.v4(),
        description = description..tripId = (id ?? _uuid.v4()),
        travelerEntity = travelerEntity ?? TravelerEntity.empty(),
        createdAt = createdAt ?? DateTime.now();

  TripEntity copyWith({
    String? responsibleCollaboratorId,
    TripDescriptionEntity? description,
    List<BagEntity>? bags,
    DateTime? time,
    bool? isDone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TripEntity(
      responsibleCollaboratorId:
          responsibleCollaboratorId ?? this.responsibleCollaboratorId,
      description: description ?? this.description,
      bags: bags ?? this.bags,
      time: time ?? this.time,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static TripEntity empty() {
    return TripEntity(
      responsibleCollaboratorId: '',
      description: TripDescriptionEntity.empty(),
      bags: [],
      time: DateTime.now(),
      isDone: false,
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }
}
