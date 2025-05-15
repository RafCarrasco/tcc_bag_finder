import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:dartz/dartz.dart';

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
