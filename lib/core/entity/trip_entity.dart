import 'package:uuid/uuid.dart';
import '../enums/bag_status_enum.dart';
import 'bag_entity.dart';
import 'traveler_entity.dart';
import 'trip_description_entity.dart';

class TripEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final TravelerEntity travelerEntity;
  final String responsibleCollaboratorId;
  final TripDescriptionEntity description;
  final DateTime time;
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
    required this.time,
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
    DateTime? time,
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
      time: time ?? this.time,
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
      time: DateTime.now(),
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
      'time': time.toIso8601String(),
      'bags': bags?.map((e) => e.toJson()).toList(),
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

 factory TripEntity.fromJson(Map<String, dynamic> json) {
  // Descrição da viagem (origem, destino)
  final description = TripDescriptionEntity(
    tripId: json['id']?.toString() ?? '',
    airportOrigin: json['origin']?.toString() ?? '',
    airportDestination: json['destination']?.toString() ?? '',
  );

  // Lista de malas associadas
  final List<BagEntity> bags = [];
  if (json['bag_id'] != null) {
    bags.add(
      BagEntity(
        id: json['bag_id'].toString(),
        ownerId: json['traveler_id']?.toString() ?? '',
        description: json['printed_code']?.toString() ?? '',
        status: BagStatusEnum.values.firstWhere(
          (e) => e.name.toUpperCase() == (json['bag_status']?.toString().toUpperCase() ?? ''),
          orElse: () => BagStatusEnum.UNKNOWN,
        ),
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
            : DateTime.now(),
        updatedAt: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at'].toString())
            : null,
      ),
    );
  }

  return TripEntity(
    id: json['id']?.toString() ?? '',
    responsibleCollaboratorId:
        json['responsibleCollaboratorId']?.toString() ?? '',
    travelerEntity: TravelerEntity.empty(),
    description: description,
    bags: bags,
    time: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
        : DateTime.now(),
    isDone: json['is_done'] == 1 ||
        json['is_done'] == true ||
        json['is_done'] == '1',
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
        : DateTime.now(),
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'].toString())
        : null,
  );
}

}
