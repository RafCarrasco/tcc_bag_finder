import 'user_entity.dart';

class CollaboratorEntity extends UserEntity {
  final String company;
  final String responsibleId;
  final int tripsCreated;

  CollaboratorEntity({
    required this.company,
    required this.responsibleId,
    this.tripsCreated = 0,
    required super.id,
    required super.email,
    required super.fullName,
    required super.phone,
    required super.role,
    required super.password, // <- obrigatório
    required super.isActive,
    required DateTime super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'company': company,
      'responsibleId': responsibleId,
      'tripsCreated': tripsCreated,
    };
  }

  factory CollaboratorEntity.fromJson(Map<String, dynamic> json) {
    return CollaboratorEntity(
      company: json['company'] ?? '',
      responsibleId: json['responsibleId'] ?? '',
      tripsCreated: json['tripsCreated'] ?? 0,
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      role: json['type'] ?? json['role'] ?? 'COLLABORATOR',
      password: json['password'] ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  factory CollaboratorEntity.fromUser(
    UserEntity user, {
    required String company,
    required String responsibleId,
    int tripsCreated = 0,
  }) {
    return CollaboratorEntity(
      id: user.id,
      email: user.email,
      fullName: user.fullName,
      phone: user.phone,
      role: user.role,
      password: user.password,
      isActive: user.isActive,
      createdAt: user.createdAt,
      company: company,
      responsibleId: responsibleId,
      tripsCreated: tripsCreated,
    );
  }

  @override
  CollaboratorEntity copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    String? role,
    String? password,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? tripsCreated,
    String? company,
    String? responsibleId,
  }) {
    return CollaboratorEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      company: company ?? this.company,
      responsibleId: responsibleId ?? this.responsibleId,
      tripsCreated: tripsCreated ?? this.tripsCreated,
    );
  }
}
