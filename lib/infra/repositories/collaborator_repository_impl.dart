import 'package:dartz/dartz.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/collaborator_failure.dart';
import '../../core/failures/trip_failure.dart';
import '../../repositories/collaborator_repository.dart';
import '../../data/datasources/collaborator_remote_datasource.dart';

class CollaboratorRepositoryImpl implements ICollaboratorRepository {
  final CollaboratorRemoteDataSource remote;

  CollaboratorRepositoryImpl(this.remote);

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

  @override
  Future<Either<TripFailure, List<TripEntity>>> getCollaboratorTripsByCollaboratorId({
    required String collaboratorId,
  }) async {
    try {
      final result = await remote.getCollaboratorTripsByCollaboratorId(collaboratorId);
      return Right(result);
    } catch (e) {
      return Left(TripReadError());
    }
  }
}
