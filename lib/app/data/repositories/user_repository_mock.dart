import 'package:tcc_bag_finder/app/data/mock/db/database_mock.dart';
import 'package:tcc_bag_finder/domain/entity/admin_entity.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:tcc_bag_finder/domain/failures/auth_failure.dart';
import 'package:tcc_bag_finder/domain/failures/collaborator_failure.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryMock implements IUserRepository {
  final MockDatabase _db;

  UserRepositoryMock(
    this._db,
  );

  @override
  Future<Either<AuthFailure, UserEntity>> addUser({
    required UserEntity user,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    UserEntity? userAlreadyRegistered = _db.users.firstWhereOrNull(
      (
        u,
      ) {
        return u.email == user.email;
      },
    );

    if (userAlreadyRegistered != null) {
      return Left(
        UserAlreadyInUse(),
      );
    }

    _db.users.add(
      user,
    );

    return Right(
      user,
    );
  }

  @override
  Future<Either<Failure, UserEntity?>> authenticateUser({
    required String email,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    UserEntity? user = _db.users.firstWhereOrNull(
      (
        user,
      ) =>
          user.email == email,
    );

    if (user == null) {
      return Left(
        UserNotFound(),
      );
    }

    if (user.password != password) {
      return Left(
        InvalidPassword(),
      );
    }

    if (user.role == UserRoleEnum.ADMIN) {
      return Right(
        user as AdminEntity,
      );
    }

    if (user.role == UserRoleEnum.COLLABORATOR) {
      return Right(
        user as CollaboratorEntity,
      );
    }

    if (user.role == UserRoleEnum.TRAVELER) {
      return Right(
        user as TravelerEntity,
      );
    }

    return Right(
      user,
    );
  }

  @override
  Future<Either<Failure, UserEntity>> deleteUser({
    required String id,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    UserEntity? user = _db.users.firstWhereOrNull(
      (
        user,
      ) =>
          user.id == id,
    );

    if (user == null) {
      return Left(
        UserNotFound(),
      );
    }

    _db.users.remove(
      user,
    );

    return Right(
      user,
    );
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    return Right(
      _db.users,
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getUserByEmail({
    required String email,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    UserEntity? user = _db.users.firstWhereOrNull(
      (
        user,
      ) =>
          user.email == email,
    );

    if (user == null) {
      return Left(
        UserNotFound(),
      );
    }

    return Right(
      user,
    );
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserById({required String id}) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    UserEntity? userAlreadyExist = _db.users.firstWhereOrNull(
      (
        user,
      ) =>
          user.id == id,
    );

    if (userAlreadyExist == null) {
      return Left(
        UserNotFound(),
      );
    }

    return Right(
      userAlreadyExist,
    );
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser({
    required UserEntity user,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    UserEntity? oldUser = _db.users.firstWhereOrNull(
      (
        u,
      ) {
        return u.id == user.id;
      },
    );

    if (oldUser == null) {
      return Left(
        UserNotFound(),
      );
    }

    _db.users.remove(
      oldUser,
    );

    _db.users.add(
      user,
    );

    return Right(
      user,
    );
  }

  @override
  Future<Either<Failure, List<String>>> getAllUsersByIds({
    List<String>? ids,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    List<String> names = _db.users
        .map(
          (u) => u.fullName,
        )
        .toList();

    if (names.isEmpty) {
      return Left(
        UserNotFound(),
      );
    }

    return Right(
      names,
    );
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersByName({
    required String name,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    List<CollaboratorEntity> collaborators = _db.users
        .whereType<CollaboratorEntity>()
        .toList()
        .where(
          (c) => c.fullName.toLowerCase().contains(
                name.toLowerCase(),
              ),
        )
        .toList();

    if (collaborators.isEmpty) {
      return Left(
        CollaboratorNotFound(),
      );
    }

    return Right(
      name.isEmpty
          ? _db.users.whereType<CollaboratorEntity>().toList()
          : collaborators,
    );
  }
}
