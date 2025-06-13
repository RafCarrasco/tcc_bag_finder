import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';

class AdminEntity extends UserEntity {
  final String company;

  AdminEntity({
    required String id,
    required super.email,
    required super.password,
    required super.fullName,
    required super.phone,
    required super.cpf,
    super.role = UserRoleEnum.ADMIN,
    required super.createdAt,
    required super.updatedAt,
    required this.company,
  }) : super(
          id: id,
        );

  @override
  AdminEntity copyWith({
    String? email,
    String? password,
    String? fullName,
    String? phone,
    String? cpf,
    UserRoleEnum? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? company,
  }) {
    return AdminEntity(
      id: id,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      cpf: cpf ?? this.cpf,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      company: company ?? this.company,
    );
  }

  factory AdminEntity.empty() {
    return AdminEntity(
      id: '',
      email: '',
      password: '',
      fullName: '',
      phone: '',
      cpf: '',
      role: UserRoleEnum.ADMIN,
      createdAt: DateTime.now(),
      updatedAt: null,
      company: '',
    );
  }

  factory AdminEntity.fromMap(Map<String, dynamic> map, {String? id}) {
    DateTime? _parseDateTime(dynamic date) {
      if (date == null) return null;
      if (date is Timestamp) return date.toDate();
      if (date is DateTime) return date;
      if (date is String) return DateTime.parse(date);
      throw FormatException('Formato de data inválido: $date');
    }
    
    return AdminEntity(
      id: id ?? map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      cpf: map['cpf'] ?? '',
      role: UserRoleEnum.values.byName(map['role'] ?? 'ADMIN'),
      createdAt: _parseDateTime(map['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDateTime(map['updatedAt']),
      company: map['company'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'phone': phone,
      'role': role.name,
      'cpf':cpf,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'company': company,
    };
  }
}