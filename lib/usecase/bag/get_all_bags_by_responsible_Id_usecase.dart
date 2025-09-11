import 'package:dartz/dartz.dart';

import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

abstract class IGetAllBagsByResponsibleIdUsecase {
  Future<Either<BagFailure, void>> call({
    required String id,
  });
}

class GetAllBagsByResponsibleIdUsecase
    implements IGetAllBagsByResponsibleIdUsecase {
  final IBagRepository repository;

  GetAllBagsByResponsibleIdUsecase({
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
