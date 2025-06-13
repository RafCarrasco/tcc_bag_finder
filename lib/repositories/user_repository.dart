import 'package:dartz/dartz.dart';
import '../core/entity/user_entity.dart';
import '../core/failures/auth_failure.dart';
import '../core/failures/failure.dart';

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
