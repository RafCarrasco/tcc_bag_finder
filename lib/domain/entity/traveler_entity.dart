import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_avatar_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_gender_enum.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'traveler_entity.g.dart';

@HiveType(typeId: 5)
class TravelerEntity extends UserEntity {
  static const Uuid _uuid = Uuid();

  @HiveField(9)
  final List<TripEntity> bags;

  TravelerEntity({
    String? id,
    required super.email,
    required super.password,
    required super.fullName,
    required super.phone,
    super.avatar,
    super.role = UserRoleEnum.TRAVELER,
    super.createdAt,
    super.updatedAt,
    List<TripEntity>? bags,
  })  : bags = bags ?? [],
        super(id: id ?? _uuid.v4());

  @override
  TravelerEntity copyWith({
    String? email,
    String? password,
    String? fullName,
    UserGenderEnum? gender,
    String? phone,
    UserAvatarEntity? avatar,
    UserRoleEnum? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TripEntity>? bags,
  }) {
    return TravelerEntity(
      id: id,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bags: bags ?? this.bags,
    );
  }

  factory TravelerEntity.empty() {
    return TravelerEntity(
      email: '',
      password: '',
      fullName: '',
      phone: '',
      avatar: null,
      role: UserRoleEnum.TRAVELER,
      createdAt: DateTime.now(),
      updatedAt: null,
      bags: [],
    );
  }
}
