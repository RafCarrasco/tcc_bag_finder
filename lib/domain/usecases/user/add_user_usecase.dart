import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/failures/auth_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

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
