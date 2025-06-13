import 'package:dartz/dartz.dart';

import '../../core/entity/trip_entity.dart';
import '../../core/failures/trip_failure.dart';
import '../../repositories/trip_repository.dart';

abstract class IAddTripUsecase {
  Future<Either<TripFailure, TripEntity>> call({
    required TripEntity trip,
  });
}

class AddTripUsecase implements IAddTripUsecase {
  final ITripRepository repository;

  AddTripUsecase({
    required this.repository,
  });

  @override
  Future<Either<TripFailure, TripEntity>> call({
    required TripEntity trip,
  }) async {
    return await repository.addTrip(
      trip: trip,
    );
  }
}
