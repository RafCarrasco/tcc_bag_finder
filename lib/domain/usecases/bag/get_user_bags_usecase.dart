import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:dartz/dartz.dart';

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
