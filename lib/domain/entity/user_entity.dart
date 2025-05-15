import 'package:tcc_bag_finder/domain/entity/user_avatar_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_gender_enum.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 9)
class UserEntity {
  static const Uuid _uuid = Uuid();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String fullName;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final UserAvatarEntity? avatar;

  @HiveField(6)
  final UserRoleEnum role;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    this.avatar,
    this.role = UserRoleEnum.OTHER,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  UserEntity copyWith({
    String? email,
    String? password,
    String? fullName,
    UserGenderEnum? gender,
    String? phone,
    UserAvatarEntity? avatar,
    UserRoleEnum? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
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
      phone: '',
      avatar: null,
      role: UserRoleEnum.OTHER,
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }
}
