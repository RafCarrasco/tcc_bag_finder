import 'package:dartz/dartz.dart';

import '../core/failures/failure.dart';
import '../repositories/user_repository.dart';


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
