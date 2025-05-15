import 'package:tcc_bag_finder/domain/entity/user_entity.dart';

abstract class IUserDatasource {
  Future<UserEntity> loginUser();
  Future<void> logout();
}
