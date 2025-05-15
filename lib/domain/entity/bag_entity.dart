import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'bag_entity.g.dart';

@HiveType(typeId: 1)
class BagEntity {
  static const Uuid _uuid = Uuid();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final String ownerId;

  @HiveField(3)
  final BagStatusEnum status;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? updatedAt;

  BagEntity({
    String? id,
    required this.ownerId,
    required this.description,
    required this.status,
    DateTime? createdAt,
    this.updatedAt,
  })  : id = id ?? _uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  BagEntity copyWith({
    String? id,
    String? description,
    BagStatusEnum? status,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BagEntity(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static BagEntity empty() {
    return BagEntity(
      id: '',
      ownerId: '',
      description: '',
      status: BagStatusEnum.UNKNOWN,
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }
}
