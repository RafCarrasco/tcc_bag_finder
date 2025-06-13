
import 'package:dartz/dartz.dart';
import '../core/entity/trip_entity.dart';
import '../core/failures/trip_failure.dart';

abstract class ITripRepository {
  Future<Either<TripFailure, TripEntity>> addTrip({
    required TripEntity trip,
  });

  Future<Either<TripFailure,bool>> isTripDone({
    required TripEntity trip,
  });

  Future<Either<TripFailure, TripEntity>> updateTrip({
    required TripEntity trip,
  });

  Future<Either<TripFailure, List<TripEntity>>> getAllTripsByResponsibleId({
    required String responsibleCollaboratorId,
  });

  Future<Either<TripFailure, List<TripEntity>>> getAllTripsByTraveler({
    required String travelerId,
  });

  Future<Either<TripFailure, List<TripEntity>>> getTripsByStatusAndId({
    required String travelerId,
    required bool? isDone,
  });

  Future<Either<TripFailure, List<TripEntity>>> getTripsById({
    required String tripId,
  });
}
