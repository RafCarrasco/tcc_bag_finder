import '../enums/user_role_enum.dart';
import 'user_entity.dart';
import 'package:uuid/uuid.dart';


class AdminEntity extends UserEntity {
  static const Uuid _uuid = Uuid();

  final String company;

  AdminEntity({
    required String id,
    required String email,
    required String fullName,
    required String phone,
    required UserRoleEnum role,
    required bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
    this.company = '',
  }) : super(
          id: id,
          email: email,
          fullName: fullName,
          phone: phone,
          role: role.name,
          isActive: isActive,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory AdminEntity.empty() {
    return AdminEntity(
      id: _uuid.v4(),
      email: '',
      fullName: '',
      phone: '',
      role: UserRoleEnum.ADMIN,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: null,
      company: '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'company': company,
    };
  }

  factory AdminEntity.fromJson(Map<String, dynamic> json) {
    return AdminEntity(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      phone: json['phone'],
      role: UserRoleEnum.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRoleEnum.ADMIN,
      ),
      isActive: json['isActive'] ?? true,
      company: json['company'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}
