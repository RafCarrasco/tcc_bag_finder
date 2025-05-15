import 'package:tcc_bag_finder/app/data/mock/db/database_mock.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/failures/collaborator_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/collaborator_repository.dart';
import 'package:dartz/dartz.dart';

class CollaboratorRepositoryMock implements ICollaboratorRepository {
  final MockDatabase _db;

  CollaboratorRepositoryMock(
    this._db,
  );

  @override
  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>>
      getCollaboratorsByResponsibleId({
    required String id,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    List<CollaboratorEntity> collaborators =
        _db.users.whereType<CollaboratorEntity>().toList().where((
      c,
    ) {
      return c.responsibleId == id;
    }).toList();

    if (collaborators.isEmpty) {
      return Left(
        CollaboratorNotFound(),
      );
    }

    return Right(
      collaborators,
    );
  }
}
