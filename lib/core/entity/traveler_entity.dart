import '../enums/user_role_enum.dart';
import 'trip_entity.dart';
import 'user_entity.dart';

class TravelerEntity extends UserEntity {
  final List<TripEntity> bags;

  TravelerEntity({
    required super.id,
    required super.email,
    required super.fullName,
    required super.phone,
    required super.role,
    required super.isActive,
    super.cpf,
    required DateTime super.createdAt,
    super.updatedAt,
    this.bags = const [],
  });

  @override
  TravelerEntity copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    String? role,
    String? cpf,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TripEntity>? bags,
  }) {
    return TravelerEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      cpf: cpf ?? this.cpf,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bags: bags ?? this.bags,
    );
  }

  factory TravelerEntity.fromJson(Map<String, dynamic> json) {
    return TravelerEntity(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      role: json['type'] ?? json['role'] ?? UserRoleEnum.TRAVELER.name,
      isActive: json['isActive'] ?? true,
      cpf: json['cpf'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
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
      isActive: true,
      cpf: null,
      createdAt: DateTime.now(),
      updatedAt: null,
      bags: [],
    );
  }
}
