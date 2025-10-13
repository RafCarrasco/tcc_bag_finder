import 'admin_entity.dart';
import 'collaborator_entity.dart';
import 'package:uuid/uuid.dart';

class UserEntity 
{static const Uuid _uuid = Uuid();
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final String role;
  final String? password;
  final bool isActive;
  final DateTime createdAt;
  final String? cpf;

  UserEntity({
    String? id,
    this.cpf,
    required this.email,
    required this.fullName,
    this.phone,
    required this.role,
    this.password,
    required this.isActive,
    required this.createdAt,
  }) : id = id ?? _uuid.v4();

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
      cpf: json['cpf'] ?? '',
      fullName: json['full_name'] ?? json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      role: json['type'] ?? json['role'] ?? 'TRAVELER',
      password: json['password'] ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'fullName': fullName,
      'email': email,
      'cpf': cpf?.replaceAll(RegExp(r'\D'), ''), 
      'phone': phone?.isEmpty == true ? null : phone,
      'role': role,
      'isActive': isActive,

    };
    
    if (password != null && password!.isNotEmpty) {
      data['password'] = password;
    }
    
    return data;
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
    String? cpf
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      cpf: cpf?? this.cpf,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
