import 'package:uuid/uuid.dart';
import 'bag_entity.dart';

class TripEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String cpf;
  final String responsibleCollaboratorId;
  final List<BagEntity>? bags;
  final bool isDone;
  final DateTime createdAt;
  final String origin;
  final String destination;
  final String? connection;

  TripEntity({
    String? id,
    required this.cpf,
    required this.responsibleCollaboratorId,
    required this.bags,
    this.isDone = false,
    DateTime? createdAt,
    required this.origin,
    required this.destination,
    this.connection,
  })  : id = id ?? _uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  TripEntity copyWith({
    String? id,
    String? cpf,
    String? responsibleCollaboratorId,
    List<BagEntity>? bags,
    bool? isDone,
    DateTime? createdAt,
    String? origin,
    String? destination,
    String? connection,
  }) {
    return TripEntity(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      responsibleCollaboratorId:
          responsibleCollaboratorId ?? this.responsibleCollaboratorId,
      bags: bags ?? this.bags,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      connection: connection ?? this.connection,
    );
  }

  factory TripEntity.empty() {
    return TripEntity(
      cpf: '',
      responsibleCollaboratorId: '',
      bags: [],
      isDone: false,
      createdAt: DateTime.now(),
      origin: '',
      destination: '',
      connection: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpf': cpf,
      'responsibleCollaboratorId': responsibleCollaboratorId,
      'bags': bags?.map((e) => e.toJson()).toList(),
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
      'origin': origin,
      'destination': destination,
      'connection': connection,
    };
  }

  factory TripEntity.fromJson(Map<String, dynamic> json) {
    return TripEntity(
      id: json['id'] ?? '',
      cpf: json['cpf'] ?? '',
      responsibleCollaboratorId: json['responsible_collaborator_id'] ??
          json['user_id'] ??
          '',
      bags: (json['bags'] as List<dynamic>?)
          ?.map((e) => BagEntity.fromJson(e))
          .toList(),
      isDone: json['isDone'] == 1 ||
          json['isDone'] == true ||
          json['is_done'] == 1 ||
          json['is_done'] == true,
      createdAt: DateTime.tryParse(json['created_at'] ?? json['createdAt'] ?? '') ??
          DateTime.now(),
      origin: json['origin'] ?? '',
      destination: json['destination'] ?? '',
      connection: json['connection'],
    );
  }
}