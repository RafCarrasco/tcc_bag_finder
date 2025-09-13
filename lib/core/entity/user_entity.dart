class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String role;
  final String? cpf;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.cpf,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? json['type'] ?? 'TRAVELER',
      cpf: json['cpf'],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      createdAt: DateTime.tryParse(json['created_at'] ?? json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] ?? json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'cpf': cpf,
      'role': role,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  UserEntity copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    String? role,
    String? cpf,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      cpf: cpf ?? this.cpf,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
