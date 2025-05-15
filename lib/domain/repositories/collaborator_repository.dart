import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/failures/collaborator_failure.dart';
import 'package:dartz/dartz.dart';

abstract class ICollaboratorRepository {
  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>>
      getCollaboratorsByResponsibleId({
    required String id,
  });
}
