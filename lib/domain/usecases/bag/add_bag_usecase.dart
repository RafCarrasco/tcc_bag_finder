import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:dartz/dartz.dart';

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
