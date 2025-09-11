import 'package:dartz/dartz.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

abstract class IGetUserActiveBagsByIdUsecase {
  Future<Either<BagFailure, List<BagEntity>>> call({
    required String userId,
    required String bagId,
  });
}

class GetUserActiveBagsByIdUsecase implements IGetUserActiveBagsByIdUsecase {
  final IBagRepository repository;

  GetUserActiveBagsByIdUsecase({
    required this.repository,
  });

  @override
  Future<Either<BagFailure, List<BagEntity>>> call({
    required String userId,
    required String bagId,
  }) async {
    return await repository.getUserActiveBagsById(
      userId: userId,
      bagId: bagId,
    );
  }
}
