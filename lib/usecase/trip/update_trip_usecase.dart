import 'package:dartz/dartz.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/failure.dart';
import '../../repositories/trip_repository.dart';

abstract class IUpdateTripUsecase {
  Future<Either<Failure, TripEntity>> call({
    required TripEntity trip,
  });
}

class UpdateTripUsecase implements IUpdateTripUsecase {
  final ITripRepository repository;

  UpdateTripUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, TripEntity>> call({
    required TripEntity trip,
  }) async {
    return await repository.updateTrip(
      trip: trip,
    );
  }
}
