import 'package:dartz/dartz.dart';
import '../core/entity/traveler_entity.dart';
import '../core/failures/failure.dart';

abstract class ITravelerRepository {
  Future<Either<Failure, List<TravelerEntity>>> getAllTravelers();

  // Future<Either<Failure, List<CollaboratorEntity>>> getCollaboratorsByResponsibleId({
  //   required String id,
  // });

  // Future<Either<Failure, CollaboratorEntity>> updateCollaborator({
  //   required CollaboratorEntity collaborator,
  // });

  // Future<Either<Failure, CollaboratorEntity>> createCollaborator({
  //   required CollaboratorEntity collaborator,
  // });
}
