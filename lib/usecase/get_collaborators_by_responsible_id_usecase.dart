import '../core/entity/collaborator_entity.dart';
import 'package:dartz/dartz.dart';
import '../core/failures/collaborator_failure.dart';
import '../repositories/collaborator_repository.dart';


abstract class IGetCollaboratorsByResponsibleIdUsecase {
  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>> call({
    required String id,
  });
}

class GetCollaboratorsByResponsibleIdUsecase
    implements IGetCollaboratorsByResponsibleIdUsecase {
  final ICollaboratorRepository repository;

  GetCollaboratorsByResponsibleIdUsecase({
    required this.repository,
  });

  @override
  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>> call({
    required String id,
  }) async {
    return await repository.getCollaboratorsByResponsibleId(
      id: id,
    );
  }
}
