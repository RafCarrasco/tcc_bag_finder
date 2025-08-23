import 'package:dartz/dartz.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/failures/collaborator_failure.dart';
import '../../repositories/collaborator_repository.dart';
import '../../data/datasources/collaborator_remote_datasource.dart';

class CollaboratorRepositoryImpl implements ICollaboratorRepository {
  final CollaboratorRemoteDataSource remote;

  CollaboratorRepositoryImpl(this.remote);

  @override
  Future<Either<CollaboratorFailure, CollaboratorEntity>> addCollaborator({required CollaboratorEntity collaborator}) async {
    try {
      final result = await remote.addCollaborator(collaborator);
      return Right(result);
    } catch (e) {
      return Left(CollaboratorCreateError());
    }
  }

  @override
  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>> getAllCollaborators() async {
    try {
      final result = await remote.getAllCollaborators();
      return Right(result);
    } catch (e) {
      return Left(CollaboratorReadError());
    }
  }

  @override
  Future<Either<CollaboratorFailure, CollaboratorEntity?>> getCollaboratorById({required String id}) async {
    try {
      final result = await remote.getCollaboratorById(id);
      return Right(result);
    } catch (e) {
      return Left(CollaboratorReadError());
    }
  }

  @override
  Future<Either<CollaboratorFailure, void>> updateCollaborator({required CollaboratorEntity collaborator}) async {
    try {
      await remote.updateCollaborator(collaborator);
      return const Right(null);
    } catch (e) {
      return Left(CollaboratorUpdateError());
    }
  }

  @override
  Future<Either<CollaboratorFailure, void>> deleteCollaborator({required String id}) async {
    try {
      await remote.deleteCollaborator(id);
      return const Right(null);
    } catch (e) {
      return Left(CollaboratorDeleteError());
    }
  }

  @override
  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>> getCollaboratorsByResponsibleId({
    required String id,
  }) async {
    try {
      final result = await remote.getCollaboratorsByResponsibleId(id);
      return Right(result);
    } catch (e) {
      return Left(CollaboratorReadError());
    }
  }
}
