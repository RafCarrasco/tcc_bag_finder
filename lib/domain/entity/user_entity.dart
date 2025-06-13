import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:uuid/uuid.dart';

class UserEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String email;
  final String password;
  final String fullName;
<<<<<<< HEAD
=======

  @HiveField(4)
  final String dateOfBirth;

  @HiveField(4)
>>>>>>> feature_design
  final String phone;
  final String cpf; 
  final UserRoleEnum role;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.dateOfBirth,
    required this.phone,
    required this.cpf, 
    this.role = UserRoleEnum.OTHER,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  UserEntity copyWith({
    String? email,
    String? password,
    String? fullName,
    String? phone,
    String? cpf,
    UserRoleEnum? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      cpf: cpf ?? this.cpf, 
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserEntity.empty() {
    return UserEntity(
      id: _uuid.v4(),
      email: '',
      password: '',
      fullName: '',
      dateOfBirth: '',
      phone: '',
      cpf: '', 
      role: UserRoleEnum.OTHER,
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }

  factory UserEntity.fromMap(Map<String, dynamic> map, {String? id}) {
    return UserEntity(
      id: id ?? map['id'] ?? _uuid.v4(),
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      cpf: map['cpf'] ?? '', 
      role: UserRoleEnum.values.byName(map['role'] ?? 'OTHER'),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'fullName': fullName,
      'phone': phone,
      'cpf': cpf, 
      'role': role.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}