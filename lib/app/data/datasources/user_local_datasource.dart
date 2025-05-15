import 'package:tcc_bag_finder/domain/entity/user_entity.dart';

abstract class IUserLocalDatasource {
  
  Future<List<UserEntity>> getUsers();

  Future<void> updateUser({
    required int index,
    required UserEntity user,
  });

  Future<void> deleteUser({
    required int index,
  });

  Future<void> addUser({
    required UserEntity user,
  });

  Future<UserEntity?> findUserById({
    required String userId,
  });

  Future<int> findUserIndexById({
    required String userId,
  });

  Future<void> clearUsers();

  Future<void> close();
}
