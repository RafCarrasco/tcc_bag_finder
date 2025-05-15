import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetBagsByIdUsecase {
  Future<Either<BagFailure, List<BagEntity>>> call({
    required String bagId,
  });
}

class GetBagsByIdUsecase implements IGetBagsByIdUsecase {
  final IBagRepository repository;

  GetBagsByIdUsecase({
    required this.repository,
  });

  @override
  Future<Either<BagFailure, List<BagEntity>>> call({
    required String bagId,
  }) async {
    return await repository.getBagsById(
      bagId: bagId,
    );
  }
}
