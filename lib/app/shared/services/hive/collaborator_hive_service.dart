import 'package:tcc_bag_finder/app/data/datasources/collaborator_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/hive_box_manager.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:hive/hive.dart';

class CollaboratorHiveLocalDatasource implements ICollaboratorLocalDatasource {
  Future<Box<UserEntity>> get storage async =>
      await HiveBoxManager.getBox<UserEntity>('users_box');

  @override
  Future<List<CollaboratorEntity>> getCollaboratorsByResponsibleId({
    required String responsibleId,
  }) async {
    var box = await storage;

    List<CollaboratorEntity>? result;

    var users = box.values
        .where(
          (e) => e.role == UserRoleEnum.COLLABORATOR,
        )
        .toList()
        .cast<CollaboratorEntity>();

    result = users
        .where(
          (e) => e.responsibleId == responsibleId,
        )
        .toList();

    return result;
  }
}
