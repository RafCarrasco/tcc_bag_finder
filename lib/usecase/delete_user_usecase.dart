import 'package:dartz/dartz.dart';

import '../core/failures/failure.dart';
import '../repositories/user_repository.dart';


abstract class IDeleteUserUsecase {
  Future<Either<Failure, void>> call({
    required String id,
  });
}

class DeleteUserUsecase implements IDeleteUserUsecase {
  final IUserRepository repository;

  DeleteUserUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call({
    required String id,
  }) async {
    return await repository.deleteUser(
      id: id,
    );
  }
}
