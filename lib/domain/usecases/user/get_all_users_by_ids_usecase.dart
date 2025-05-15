import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetAllUsersByIdsUsecase {
  Future<Either<Failure, List<String>>> call({
    required List<String> collaboratorIds,
  });
}

class GetAllUsersByIdsUsecase implements IGetAllUsersByIdsUsecase {
  final IUserRepository repository;

  GetAllUsersByIdsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call({
    required List<String> collaboratorIds,
  }) async {
    return await repository.getAllUsersByIds(
      ids: collaboratorIds,
    );
  }
}
