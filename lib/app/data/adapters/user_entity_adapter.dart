import 'package:tcc_bag_finder/app/data/adapters/user_avatar_entity_adapter.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';

class UserEntityAdapter {
  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      dateOfBirth: json['dateOfBirth'],
      phone: json['phone'],
      cpf: json['cpf'],
      role: UserRoleEnum.values.firstWhere((e) => e.name == json['role'],
          orElse: () => UserRoleEnum.OTHER),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  static List<UserEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }

  static Map<String, dynamic> toJson(UserEntity user) {
    return {
      'id': user.id,
      'email': user.email,
      'password': user.password,
      'fullName': user.fullName,
      'phone': user.phone,
      'cpf':user.cpf,
      'role': user.role.name,
      'createdAt': user.createdAt.toIso8601String(),
      'updatedAt': user.updatedAt?.toIso8601String(),
    };
  }
}
