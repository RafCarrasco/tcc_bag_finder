import '../core/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../core/failures/failure.dart';
import '../repositories/user_repository.dart';


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
