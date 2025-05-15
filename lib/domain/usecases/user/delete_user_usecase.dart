import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

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
