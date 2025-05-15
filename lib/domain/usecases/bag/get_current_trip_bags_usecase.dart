import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:dartz/dartz.dart';

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
