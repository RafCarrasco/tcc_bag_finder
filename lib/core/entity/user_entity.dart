import 'admin_entity.dart';
import 'collaborator_entity.dart';

class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String role;
  final String password;
  final bool isActive;
  final DateTime createdAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.password,
    required this.isActive,
    required this.createdAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    final role = json['role'] ?? '';
    if (role == 'ADMIN') {
      return AdminEntity.fromJson(json);
    } else if (role == 'COLLABORATOR') {
      return CollaboratorEntity.fromJson(json);
    }
    return UserEntity(
      id: json['id'].toString() ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      role: json['type'] ?? json['role'] ?? 'TRAVELER',
      password: json['password'] ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'password': password,
      'role': role,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  UserEntity copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    String? role,
    String? password,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
