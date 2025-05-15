import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:dartz/dartz.dart';

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
