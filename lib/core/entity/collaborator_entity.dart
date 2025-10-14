import 'user_entity.dart';

class CollaboratorEntity extends UserEntity {
  final String company_id;

  CollaboratorEntity({
    required this.company_id,
    String? id,
    super.cpf,
    required super.email,
    required super.fullName,
    required super.phone,
    required super.role,
    required super.password,
    required super.isActive,
    required DateTime super.createdAt,
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'company_id': company_id,
    };
  }

  factory CollaboratorEntity.fromJson(Map<String, dynamic> json) {
    return CollaboratorEntity(
      company_id: json['company_id'] ?? '',
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? json['full_name'] ?? '',
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
      company_id: company,
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
    String? cpf
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
      company_id: company_id ?? this.company_id,
    );
  }
}
