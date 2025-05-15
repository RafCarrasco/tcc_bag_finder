import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/failures/trip_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

abstract class ICheckDoneTripUsecase {
  Future<Either<TripFailure, bool>> call({
    required TripEntity trip,
  });
}

class CheckDoneTripUsecase implements ICheckDoneTripUsecase {
  final ITripRepository repository;

  CheckDoneTripUsecase({
    required this.repository,
  });

  @override
  Future<Either<TripFailure, bool>> call({
    required TripEntity trip,
  }) async {
    return await repository.isTripDone(
      trip: trip,
    );
  }
}
