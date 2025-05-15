import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/failures/collaborator_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/collaborator_repository.dart';
import 'package:dartz/dartz.dart';

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
