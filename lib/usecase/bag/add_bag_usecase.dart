import 'package:dartz/dartz.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

abstract class IAddBagUsecase {
  Future<Either<BagFailure, BagEntity>> call({
    required BagEntity bag,
  });
}

class AddBagUsecase implements IAddBagUsecase {
  final IBagRepository repository;

  AddBagUsecase({
    required this.repository,
  });

  @override
  Future<Either<BagFailure, BagEntity>> call({
    required BagEntity bag,
  }) async {
    return await repository.addBag(
      bag: bag,
    );
  }
}
