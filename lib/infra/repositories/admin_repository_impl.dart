import 'package:dartz/dartz.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/admin_failure.dart';
import '../../repositories/admin_repository.dart';
import '../../data/datasources/admin_remote_datasource.dart';

class AdminRepositoryImpl implements IAdminRepository {
  final AdminRemoteDataSource remote;

  AdminRepositoryImpl(this.remote);

  @override
  Future<Either<AdminFailure, List<CollaboratorEntity>>> getCollaboratorsByResponsibleId({
    required String id,
  }) async {
    try {
      final result = await remote.getCollaboratorsByResponsibleId(id);
      return Right(result);
    } catch (e) {
      return Left(AdminNotFound());
    }
  }

  @override
  Future<Either<AdminFailure, List<TripEntity>>> getCollaboratorTripsByCollaboratorId({
    required String collaboratorId,
  }) async {
    try {
      final result = await remote.getCollaboratorTripsByCollaboratorId(collaboratorId);
      return Right(result);
    } catch (e) {
      return Left(AdminNotFound());
    }
  }
}
