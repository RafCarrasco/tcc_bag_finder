import '../core/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../core/failures/failure.dart';
import '../repositories/user_repository.dart';


abstract class ILoginUserUsecase {
  Future<Either<Failure, UserEntity?>> call({
    required String email,
    required String password,
  });
}

class LoginUserUsecase implements ILoginUserUsecase {
  final IUserRepository repository;

  LoginUserUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, UserEntity?>> call({
    required String email,
    required String password,
  }) async {
    return await repository.authenticateUser(
      email: email,
      password: password,
    );
  }
}
