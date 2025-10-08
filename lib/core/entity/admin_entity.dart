import '../enums/user_role_enum.dart';
import 'user_entity.dart';

class AdminEntity extends UserEntity {
  final String company;

  AdminEntity({
    required String id,
    required String email,
    required String fullName,
    required String phone,
    required String role,
    required String password,
    required bool isActive,
    required DateTime createdAt,
    String? cpf,
    this.company = '',
  }) : super(
          id: id,
          email: email,
          fullName: fullName,
          phone: phone,
          role: role,
          password: password,
          isActive: isActive,
          createdAt: createdAt,
          cpf: cpf
        );

  factory AdminEntity.empty() {
    return AdminEntity(
      id: '',
      email: '',
      fullName: '',
      phone: '',
      role: UserRoleEnum.ADMIN.name,
      password: '',
      isActive: true,
      createdAt: DateTime.now(),
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
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? UserRoleEnum.ADMIN.name,
      password: json['password'] ?? '',
      isActive: json['isActive'] ?? true,
      company: json['company'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
