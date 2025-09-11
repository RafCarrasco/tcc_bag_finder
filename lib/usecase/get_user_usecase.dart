import '../core/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../core/failures/failure.dart';
import '../repositories/user_repository.dart';


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
