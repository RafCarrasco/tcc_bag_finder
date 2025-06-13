import 'package:dartz/dartz.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/trip_failure.dart';
import '../../repositories/trip_repository.dart';

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
