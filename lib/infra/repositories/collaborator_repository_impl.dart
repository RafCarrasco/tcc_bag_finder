import 'package:bag_finder/core/entity/traveler_entity.dart';
import 'package:bag_finder/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';
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

  @override
  Future<Either<Failure, List<TravelerEntity>>> getAllTravelers() async {
    try {
      final result = await remote.getAllTravelers();
      return Right(result);
    } catch (e) {
      return Left(CollaboratorTripsError(message: "Erro ao buscar trips por travelerId"));
    }
  }
}
