import 'package:dartz/dartz.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/enums/bag_status_enum.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

abstract class IGetBagsByStatusUsecase {
  Future<Either<BagFailure, List<BagEntity>>> call({
    required BagStatusEnum status,
  });
}

class GetBagsByStatusUsecase implements IGetBagsByStatusUsecase {
  final IBagRepository repository;

  GetBagsByStatusUsecase({
    required this.repository,
  });

  @override
  Future<Either<BagFailure, List<BagEntity>>> call({
    required BagStatusEnum status,
  }) async {
    return await repository.getBagsByStatus(
      status: status,
    );
  }
}
