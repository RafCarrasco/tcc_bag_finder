import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/failures/auth_failure.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IUserRepository {
  Future<Either<AuthFailure, UserEntity>> addUser({
    required UserEntity user,
  });

  Future<Either<Failure, UserEntity?>> getUserById({
    required String id,
  });

  Future<Either<Failure, UserEntity>> updateUser({
    required UserEntity user,
  });

  Future<Either<Failure, void>> deleteUser({
    required String id,
  });

  Future<Either<Failure, List<UserEntity>>> getAllUsers();

  Future<Either<Failure, List<String>>> getAllUsersByIds({
    List<String>? ids,
  });

  Future<Either<Failure, UserEntity>> getUserByEmail({
    required String email,
  });

  Future<Either<Failure, List<UserEntity>>> getUsersByName({
    required String name,
  });

  Future<Either<Failure, UserEntity?>> authenticateUser({
    required String email,
    required String password,
  });
}
