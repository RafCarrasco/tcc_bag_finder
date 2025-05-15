import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:hive/hive.dart';

part 'report_entity.g.dart';

@HiveType(typeId: 3)
class ReportEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final UserEntity userId;

  @HiveField(3)
  final BagEntity bagEntity;

  ReportEntity({
    required this.id,
    required this.description,
    required this.userId,
    required this.bagEntity,
  });

  ReportEntity copyWith({
    String? id,
    String? description,
    UserEntity? userId,
    BagEntity? bagEntity,
  }) {
    return ReportEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      bagEntity: bagEntity ?? this.bagEntity,
    );
  }

  static ReportEntity empty() {
    return ReportEntity(
      id: '',
      description: '',
      userId: UserEntity.empty(),
      bagEntity: BagEntity.empty(),
    );
  }
}
