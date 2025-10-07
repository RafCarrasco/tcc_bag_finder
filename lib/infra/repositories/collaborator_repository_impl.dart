import 'package:dartz/dartz.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/entity/tag_entity.dart';
import '../../core/failures/collaborator_failure.dart';
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
  Future<Either<CollaboratorFailure, List<TripEntity>>> getTripsByTravelerId({
    required String travelerId,
    required String responsibleId,
  }) async {
    try {
      final result = await remote.getTripsByTravelerId(
        travelerId: travelerId,
        responsibleId: responsibleId,
      );
      return Right(result);
    } catch (e) {
      return Left(CollaboratorTripsError());
    }
  }

  @override
  Future<Either<CollaboratorFailure, List<TripEntity>>> getAllTripsByResponsible({
    required String responsibleId,
  }) async {
    try {
      final result = await remote.getAllTripsByResponsible(responsibleId);
      return Right(result);
    } catch (e) {
      return Left(CollaboratorTripsError());
    }
  }
  Future<Either<CollaboratorFailure, List<TripEntity>>> getAllTripsByTravelerFullName({
    required String fullName,
  }) async {
    try {
      final result = await remote.getAllTripsByResponsible(fullName);
      return Right(result);
    } catch (e) {
      return Left(CollaboratorTripsError());
    }
  }
  
  Future<void> setResponsibleId({
    required String responsibleId,
    required String userId,
  }) async {
    try {
      final result = await remote.setResponsibleId(userId,responsibleId);
      Right(result);
    } catch (e) {
      Left(CollaboratorTripsError());
    }
  }
  
  Future<Either<CollaboratorFailure, Unit>> insertTag(TagEntity tag) async {
    try {
      await remote.insertTag(tag);
      return const Right(unit);
    } catch (e) {
      return Left(CollaboratorTripsError());
    }
  }
}
