import 'package:dartz/dartz.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

abstract class IGetBagsByEPCUsecase {
  Future<Either<BagFailure, List<BagEntity>>> call({required String epc});
}

class GetBagsByEPCUsecase implements IGetBagsByEPCUsecase {
  final IBagRepository repository;

  GetBagsByEPCUsecase({required this.repository});

  @override
  Future<Either<BagFailure, List<BagEntity>>> call({required String epc}) async {
    return await repository.getBagsByEPC(epc: epc);
  }
}