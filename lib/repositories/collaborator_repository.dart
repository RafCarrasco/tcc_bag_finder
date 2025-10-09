import 'package:dartz/dartz.dart';
import '../core/entity/trip_entity.dart';
import '../core/failures/failure.dart';

abstract class ICollaboratorRepository {

  Future<Either<Failure, List<TripEntity>>> getTripsByTravelerId({
    required String travelerId,
    required String responsibleId,
  });

  Future<Either<Failure, List<TripEntity>>> getAllTripsByResponsible({
    required String responsibleId,
  });
}
