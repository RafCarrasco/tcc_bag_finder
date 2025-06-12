import 'package:tcc_bag_finder/domain/entity/user_avatar_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_gender_enum.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'collaborator_entity.g.dart';

@HiveType(typeId: 2)
class CollaboratorEntity extends UserEntity {
  static const Uuid _uuid = Uuid();

  @HiveField(9)
  final String company;

  @HiveField(10)
  final bool isActive;

  @HiveField(12)
  final String responsibleId;

  @HiveField(13)
  final int tripsCreated;

  CollaboratorEntity({
    String? id,
    required super.email,
    required super.password,
    required super.fullName,
    required super.dateOfBirth,
    required super.phone,
    required this.company,
    this.isActive = false,
    this.tripsCreated = 0,
    required this.responsibleId,
    super.avatar,
    super.role = UserRoleEnum.COLLABORATOR,
    super.createdAt,
    super.updatedAt,
  }) : super(id: id ?? _uuid.v4());

  @override
  CollaboratorEntity copyWith({
    String? email,
    String? password,
    String? fullName,
    String? dateOfBirth,
    UserGenderEnum? gender,
    String? phone,
    UserAvatarEntity? avatar,
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
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
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
      dateOfBirth: '',
      phone: '',
      avatar: null,
      role: UserRoleEnum.COLLABORATOR,
      createdAt: DateTime.now(),
      updatedAt: null,
      company: '',
      isActive: false,
      tripsCreated: 0,
      responsibleId: '',
    );
  }
}
