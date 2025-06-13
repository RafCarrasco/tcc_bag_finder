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
    required super.isActive,
    required DateTime super.createdAt,
    super.updatedAt,
    super.cpf,
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
      company: json['company'],
      responsibleId: json['responsibleId'],
      tripsCreated: json['tripsCreated'] ?? 0,
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      phone: json['phone'],
      role: json['type'] ?? json['role'],
      isActive: json['isActive'] ?? true,
      cpf: json['cpf'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
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
      isActive: user.isActive,
      cpf: user.cpf,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
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
    bool? isActive,
    String? cpf,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? tripsCreated,
  }) {
    return CollaboratorEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      cpf: cpf ?? this.cpf,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      company: company,
      responsibleId: responsibleId,
      tripsCreated: tripsCreated ?? this.tripsCreated,
    );
  }
}
