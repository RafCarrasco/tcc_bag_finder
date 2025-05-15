import 'package:tcc_bag_finder/app/data/adapters/user_entity_adapter.dart'
    as user_adapter;
import 'package:tcc_bag_finder/app/data/datasources/hive_box_manager.dart';
import 'package:tcc_bag_finder/app/data/datasources/user_local_datasource.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:hive/hive.dart';

class UserHiveLocalDatasource implements IUserLocalDatasource {
  Future<Box<UserEntity>> get storage async =>
      await HiveBoxManager.getBox<UserEntity>('users_box');
  @override
  Future<void> addUser({
    required UserEntity user,
  }) async {
    var box = await storage;

    try {
      await box.add(
        user,
      );
    } catch (e) {
      GlobalSnackBar.error(
        ServerStorageFailure().errorMessage,
      );
    }
  }

  @override
  Future<void> updateUser({
    required int index,
    required UserEntity user,
  }) async {
    var box = await storage;

    try {
      await box.putAt(
        index,
        user,
      );
    } catch (e) {
      GlobalSnackBar.error(
        ServerStorageFailure().errorMessage,
      );
    }
  }

  @override
  Future<void> deleteUser({
    required int index,
  }) async {
    var box = await storage;

    try {
      await box.deleteAt(
        index,
      );
    } catch (e) {
      GlobalSnackBar.error(
        ServerStorageFailure().errorMessage,
      );
    }
  }

  @override
  Future<UserEntity?> findUserById({
    required String userId,
  }) async {
    var box = await storage;
    UserEntity? result;

    var users = box.values.toList();

    for (var user in users) {
      if (user.id == userId) {
        result = user;
        break;
      }
    }

    return result;
  }

  @override
  Future<int> findUserIndexById({
    required String userId,
  }) async {
    List<UserEntity> users = await getUsers();
    int index = users.indexWhere(
      (element) => element.id == userId,
    );

    return index;
  }

  @override
  Future<void> clearUsers() async {
    var box = await storage;
    await box.clear();
  }

  @override
  Future<void> close() async {
    var box = await storage;
    await box.close();
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    var box = await storage;
    List user = box.values.toList();

    return user_adapter.UserEntityAdapter.fromJsonList(
      user,
    );
  }
}
