import 'package:dartz/dartz.dart';
import '../core/entity/user_entity.dart';
import '../core/failures/failure.dart';
import '../repositories/user_repository.dart';

abstract class IUpdateUserUsecase {
  Future<Either<Failure, UserEntity>> call({
    required UserEntity user,
  });
}

class UpdateUserUsecase implements IUpdateUserUsecase {
  final IUserRepository repository;

  UpdateUserUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, UserEntity>> call({
    required UserEntity user,
  }) async {
    return await repository.updateUser(
      user: user,
    );
  }
}
