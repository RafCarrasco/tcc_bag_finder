import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetUserUsecase {
  Future<Either<Failure, UserEntity?>> call({
    required String userId,
  });
}

class GetUserUsecase implements IGetUserUsecase {
  final IUserRepository repository;

  GetUserUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, UserEntity?>> call({
    required String userId,
  }) async {
    return await repository.getUserById(
      id: userId,
    );
  }
}
