import 'package:bag_finder/core/exceptions/authentication_exceptions.dart';
import 'package:bag_finder/data/datasources/user_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import '../../../core/entity/user_entity.dart';
import '../../../core/failures/auth_failure.dart';
import '../../../core/failures/failure.dart';
import '../../../repositories/user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  final UserRemoteDataSource remote;

  UserRepositoryImpl(this.remote);

@override
Future<Either<AuthFailure, UserEntity>> addUser({required UserEntity user}) async {
  try {

    final result = await remote.addUser(user);
    return Right(result);
  } on UserAlreadyInUseException {

    return Left(UserAlreadyInUse()); 
    
  } catch (e) {
      return Left(UserAlreadyInUse());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserById({required String id}) async {
    try {
      final result = await remote.getUserById(id);
      return Right(result);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final result = await remote.getAllUsers();
      return Right(result);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(
      {required UserEntity user}) async {
    try {
      final result = await remote.updateUser(user);
      return Right(result);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser({required String id}) async {
    try {
      await remote.deleteUser(id);
      return const Right(null);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllUsersByIds(
      {List<String>? ids}) async {
    try {
      if (ids == null || ids.isEmpty) return const Right([]);
      final result = await remote.getAllUsersByIds(ids);
      return Right(result);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserByEmail(
      {required String email}) async {
    try {
      final result = await remote.getUserByEmail(email);
      if (result == null) return Left(NoDataFound());
      return Right(result);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersByName(
      {required String name}) async {
    try {
      final result = await remote.getUsersByName(name);
      return Right(result);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> authenticateUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remote.authenticateUser(email, password);
      return Right(result);
    } on AuthenticationFailedException {
      return Left(AuthenticationFailure());
    } on Exception catch (e, stack) {
      print(e);
      return Left(UnknownError(stackTrace: stack));
    } catch (e, stack) {
      return Left(UnknownError(stackTrace: stack));
    }
  }

  Future<Either<Failure, UserEntity?>> getUserByCpf(
      {required String cpf}) async {
    try {
      final result = await remote.getUserByCpf(cpf);
      return Right(result);
    } catch (e) {
      print("Erro ao buscar CPF no repositório: $e");
      return Left(UnknownError());
    }
  }

  Future<Either<Failure, UserEntity?>> checkIfCpfExists(
      {required String cpf}) async {
    return getUserByCpf(cpf: cpf);
  }
}
