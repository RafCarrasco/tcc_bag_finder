import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:tcc_bag_finder/domain/entity/user_avatar_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_gender_enum.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';

part 'admin_entity.g.dart';

@HiveType(typeId: 0)
class AdminEntity extends UserEntity {
  static const Uuid _uuid = Uuid();

  @HiveField(9)
  final String company;

  AdminEntity({
    String? id,
    required super.email,
    required super.password,
    required super.fullName,
    required super.dateOfBirth,
    required super.phone,
    super.avatar,
    super.role = UserRoleEnum.ADMIN,
    required super.createdAt,
    required super.updatedAt,
    required this.company,
  }) : super(
          id: id ?? _uuid.v4(),
        );

  @override
  AdminEntity copyWith({
    String? email,
    String? password,
    String? fullName,
    UserGenderEnum? gender,
    String? phone,
    UserAvatarEntity? avatar,
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
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      company: company ?? this.company,
    );
  }

  factory AdminEntity.empty() {
    return AdminEntity(
      email: '',
      password: '',
      fullName: '',
      dateOfBirth: '',
      phone: '',
      avatar: null,
      role: UserRoleEnum.ADMIN,
      createdAt: DateTime.now(),
      updatedAt: null,
      company: '',
    );
  }
}
