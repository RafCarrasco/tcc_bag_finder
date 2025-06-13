import 'package:dartz/dartz.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

abstract class IGetUserBagsUsecase {
  Future<Either<BagFailure, List<BagEntity>>> call({
    required String userId,
  });
}

class GetUserBagsUsecase implements IGetUserBagsUsecase {
  final IBagRepository repository;

  GetUserBagsUsecase({
    required this.repository,
  });

  @override
  Future<Either<BagFailure, List<BagEntity>>> call({
    required String userId,
  }) async {
    return await repository.getBagsByUserId(
      userId: userId,
    );
  }
}
