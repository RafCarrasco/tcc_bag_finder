import 'package:dartz/dartz.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

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
