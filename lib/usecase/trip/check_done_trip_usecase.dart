import 'package:dartz/dartz.dart';

import '../../core/entity/trip_entity.dart';
import '../../core/failures/trip_failure.dart';
import '../../repositories/trip_repository.dart';

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
