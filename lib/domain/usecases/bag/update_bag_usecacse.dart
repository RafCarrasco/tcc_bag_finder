import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IUpdateBagUsecase {
  Future<Either<BagFailure, void>> call({
    required BagEntity bag,
  });
}

class UpdateBagUsecase implements IUpdateBagUsecase {
  final IBagRepository repository;

  UpdateBagUsecase({
    required this.repository,
  });

  @override
  Future<Either<BagFailure, void>> call({
    required BagEntity bag,
  }) async {
    return await repository.updateBag(
      bag: bag,
    );
  }
}
