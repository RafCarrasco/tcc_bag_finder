import 'package:dartz/dartz.dart';
import '../core/entity/collaborator_entity.dart';
import '../core/entity/trip_entity.dart';
import '../core/failures/admin_failure.dart';

abstract class IAdminRepository {
  Future<Either<AdminFailure, List<CollaboratorEntity>>> getCollaborators();

  Future<Either<AdminFailure, List<TripEntity>>> getCollaboratorTripsByCollaboratorId({
    required String collaboratorId,
  });
}
