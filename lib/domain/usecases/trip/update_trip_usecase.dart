import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

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
