import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

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
