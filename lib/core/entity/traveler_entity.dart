import '../enums/user_role_enum.dart';
import 'trip_entity.dart';
import 'user_entity.dart';

class TravelerEntity extends UserEntity {
  final List<TripEntity> bags;

  TravelerEntity({
    String? id,
    required super.email,
    required super.fullName,
    required super.phone,
    required super.role,
    super.cpf,
    required super.password,
    required super.isActive,
    required DateTime super.createdAt,
    this.bags = const [],
  }) : super(id: id);

  @override
  TravelerEntity copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    String? role,
    String? cpf,
    String? password,
    bool? isActive,
    DateTime? createdAt,
    List<TripEntity>? bags,
  }) {
    return TravelerEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      bags: bags ?? this.bags,
    );
  }

  factory TravelerEntity.fromJson(Map<String, dynamic> json) {
    return TravelerEntity(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['type'] ?? json['role'] ?? UserRoleEnum.TRAVELER.name,
      password: json['password'] ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      bags: (json['bags'] as List<dynamic>? ?? [])
          .map((e) => TripEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'bags': bags.map((e) => e.toJson()).toList(),
    };
  }

  factory TravelerEntity.empty() {
    return TravelerEntity(
      id: '',
      email: '',
      fullName: '',
      phone: '',
      role: UserRoleEnum.TRAVELER.name,
      password: '',
      isActive: true,
      createdAt: DateTime.now(),
      bags: [],
    );
  }
}
