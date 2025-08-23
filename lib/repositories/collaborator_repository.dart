import 'package:dartz/dartz.dart';
import '../core/entity/collaborator_entity.dart';
import '../core/entity/trip_entity.dart';
import '../core/failures/collaborator_failure.dart';
import '../core/failures/trip_failure.dart';

abstract class ICollaboratorRepository {
  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>> getCollaboratorsByResponsibleId({
    required String id,
  });

  Future<Either<TripFailure, List<TripEntity>>> getCollaboratorTripsByCollaboratorId({
    required String collaboratorId,
  });
}
