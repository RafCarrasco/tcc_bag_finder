import 'package:dartz/dartz.dart';
import '../core/entity/collaborator_entity.dart';
import '../core/entity/traveler_entity.dart';
import '../core/entity/trip_entity.dart';
import '../core/failures/collaborator_failure.dart';
import '../core/failures/failure.dart';

abstract class ICollaboratorRepository {

  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>> getCollaboratorsByResponsibleId({
    required String id,
  });

  Future<Either<Failure, List<TripEntity>>> getTripsByTravelerId({
    required String travelerId,
    required String responsibleId,
  });

  Future<Either<Failure, List<TripEntity>>> getAllTripsByResponsible({
    required String responsibleId,
  });

  Future<Either<Failure, List<TravelerEntity>>> getAllTravelers();
}
