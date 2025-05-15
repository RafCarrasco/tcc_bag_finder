import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDeleteBagUsecase {
  Future<Either<BagFailure, void>> call({
    required String id,
  });
}

class DeleteBagUsecase implements IDeleteBagUsecase {
  final IBagRepository repository;

  DeleteBagUsecase({
    required this.repository,
  });

  @override
  Future<Either<BagFailure, void>> call({
    required String id,
  }) async {
    return await repository.deleteBag(
      bagId: id,
    );
  }
}
