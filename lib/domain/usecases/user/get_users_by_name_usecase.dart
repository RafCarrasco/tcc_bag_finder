import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetUsersByNameUsecase {
  Future<Either<Failure, List<UserEntity>>> call({
    required String name,
  });
}

class GetUsersByNameUsecase implements IGetUsersByNameUsecase {
  final IUserRepository repository;

  GetUsersByNameUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> call({
    required String name,
  }) async {
    return await repository.getUsersByName(
      name: name,
    );
  }
}
