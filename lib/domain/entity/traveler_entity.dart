import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TravelerEntity extends UserEntity {

  final List<TripEntity> bags;

  TravelerEntity({
    required String id,
    required super.email,
    required super.password,
    required super.fullName,
    required super.phone,
    required super.cpf,
    super.role = UserRoleEnum.TRAVELER,
    super.createdAt,
    super.updatedAt,
    List<TripEntity>? bags,
  })  : bags = bags ?? [],
        super(id:id);

@override
TravelerEntity copyWith({
  String? email,
  String? password,
  String? fullName,
  String? phone,
  String? cpf,
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
    cpf: cpf ?? this.cpf,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    bags: bags ?? this.bags,
  );
}

  factory TravelerEntity.empty() {
    return TravelerEntity(
      id: '',
      email: '',
      password: '',
      fullName: '',
      phone: '',
      cpf: '',
      role: UserRoleEnum.TRAVELER,
      createdAt: DateTime.now(),
      updatedAt: null,
      bags: [],
    );
  }

  factory TravelerEntity.fromMap(Map<String, dynamic> map, {String? id}) {
    DateTime? _parseDateTime(dynamic date) {
      if (date == null) return null;
      if (date is Timestamp) return date.toDate();
      if (date is DateTime) return date;
      if (date is String) return DateTime.parse(date);
      throw FormatException('Formato de data inválido: $date');
  }
    return TravelerEntity(
      id: id ?? map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      cpf: map['cpf'] ?? '',
      role: UserRoleEnum.values.byName(map['role'] ?? 'TRAVELER'),
      createdAt: _parseDateTime(map['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDateTime(map['updatedAt']),
      bags: map['bags'] != null
          ? List<TripEntity>.from(
              (map['bags'] as List).map(
                (trip) => TripEntity.fromMap(trip),
              ),
            )
          : [],
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'bags': bags.map((trip) => trip.toMap()).toList(),
    };
  }
}
