import 'package:uuid/uuid.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollaboratorEntity extends UserEntity {
  static const Uuid _uuid = Uuid();

  final String company;
  final bool isActive;
  final String responsibleId;
  final int tripsCreated;

  CollaboratorEntity({
    String? id,
    required super.email,
    required super.password,
    required super.fullName,
    required super.phone,
    required super.cpf,
    required this.company,
    this.isActive = false,
    this.tripsCreated = 0,
    required this.responsibleId,
    super.role = UserRoleEnum.COLLABORATOR,
    super.createdAt,
    super.updatedAt,
  }) : super(id: id ?? _uuid.v4());

  @override
  CollaboratorEntity copyWith({
    String? email,
    String? password,
    String? fullName,
    String? phone,
    String? cpf,
    UserRoleEnum? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? company,
    bool? isActive,
    int? tripsCreated,
    String? responsibleId,
  }) {
    return CollaboratorEntity(
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
      isActive: isActive ?? this.isActive,
      tripsCreated: tripsCreated ?? this.tripsCreated,
      responsibleId: responsibleId ?? this.responsibleId,
    );
  }

  factory CollaboratorEntity.empty() {
    return CollaboratorEntity(
      email: '',
      password: '',
      fullName: '',
      phone: '',
      cpf: '',
      role: UserRoleEnum.COLLABORATOR,
      createdAt: DateTime.now(),
      updatedAt: null,
      company: '',
      isActive: false,
      tripsCreated: 0,
      responsibleId: '',
    );
  }

  factory CollaboratorEntity.fromMap(Map<String, dynamic> map, {String? id}) {
    DateTime? _parseDateTime(dynamic date) {
      if (date == null) return null;
      if (date is Timestamp) return date.toDate();
      if (date is DateTime) return date;
      if (date is String) return DateTime.parse(date);
      throw FormatException('Formato de data inválido: $date');
  }
    return CollaboratorEntity(
      id: id,
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      cpf: map['cpf'] ?? '',
      role: UserRoleEnum.values.byName(map['role'] ?? 'COLLABORATOR'),
      createdAt: _parseDateTime(map['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDateTime(map['updatedAt']),
      company: map['company'] ?? '',
      isActive: map['isActive'] ?? false,
      tripsCreated: map['tripsCreated'] ?? 0,
      responsibleId: map['responsibleId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'phone': phone,
      'cpf':cpf,
      'role': role.name,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'company': company,
      'isActive': isActive,
      'tripsCreated': tripsCreated,
      'responsibleId': responsibleId,
    };
  }
}
