import '../core/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../core/failures/auth_failure.dart';
import '../repositories/user_repository.dart';


abstract class IAddUserUsecase {
  Future<Either<AuthFailure, UserEntity>> call({
    required UserEntity user,
  });
}

class AddUserUsecase implements IAddUserUsecase {
  final IUserRepository repository;

  AddUserUsecase({required this.repository});

  @override
  Future<Either<AuthFailure, UserEntity>> call({
    required UserEntity user,
  }) async {
    return await repository.addUser(
      user: user,
    );
  }
}
