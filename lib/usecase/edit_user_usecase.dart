import 'package:dartz/dartz.dart';
import '../core/entity/user_entity.dart';
import '../core/failures/failure.dart';
import '../repositories/user_repository.dart';

abstract class IEditUserUsecase {
  Future<Either<Failure, UserEntity>> call({
    required UserEntity user,
  });
}

class EditUserUsecase implements IEditUserUsecase {
  final IUserRepository repository;

  EditUserUsecase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call({
    required UserEntity user,
  }) async {
    return await repository.updateUser(
      user: user,
    );
  }
}
