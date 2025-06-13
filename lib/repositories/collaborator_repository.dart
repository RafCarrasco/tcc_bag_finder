import 'package:dartz/dartz.dart';
import '../core/entity/collaborator_entity.dart';
import '../core/failures/collaborator_failure.dart';

abstract class ICollaboratorRepository {
  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>>
      getCollaboratorsByResponsibleId({
    required String id,
  });
}
