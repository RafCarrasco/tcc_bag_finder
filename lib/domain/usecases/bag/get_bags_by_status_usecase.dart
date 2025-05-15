import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:dartz/dartz.dart';

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
