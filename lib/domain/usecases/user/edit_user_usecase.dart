import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

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
