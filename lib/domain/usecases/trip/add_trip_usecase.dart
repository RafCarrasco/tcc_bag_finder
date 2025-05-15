import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/failures/trip_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

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
