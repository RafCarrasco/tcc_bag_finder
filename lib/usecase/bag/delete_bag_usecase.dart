import 'package:dartz/dartz.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

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
