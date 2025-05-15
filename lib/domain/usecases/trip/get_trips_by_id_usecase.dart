import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/failures/trip_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetTripsByIdUsecase {
  Future<Either<TripFailure, List<TripEntity>>> call({
    required String tripId,
  });
}

class GetTripsByIdUsecase implements IGetTripsByIdUsecase {
  final ITripRepository repository;

  GetTripsByIdUsecase({
    required this.repository,
  });

  @override
  Future<Either<TripFailure, List<TripEntity>>> call({
    required String tripId,
  }) async {
    return await repository.getTripsById(
      tripId: tripId,
    );
  }
}
