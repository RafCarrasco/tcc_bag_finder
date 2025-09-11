import 'package:dartz/dartz.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';

abstract class IGetCurrentTripBagsByIdUsecase {
  Future<Either<BagFailure, List<BagEntity>>> call({
    required String bagId,
    required TripEntity trip,
  });
}

class GetCurrentTripBagsByIdUsecase implements IGetCurrentTripBagsByIdUsecase {
  final IBagRepository repository;

  GetCurrentTripBagsByIdUsecase({
    required this.repository,
  });

  @override
  Future<Either<BagFailure, List<BagEntity>>> call({
    required String bagId,
    required TripEntity trip,
  }) async {
    return await repository.getCurrentTripBagsById(
      bagId: bagId,
      trip: trip,
    );
  }
}
