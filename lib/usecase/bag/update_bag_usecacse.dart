import 'package:dartz/dartz.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

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
