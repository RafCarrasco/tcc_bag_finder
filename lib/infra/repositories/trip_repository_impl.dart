import 'package:dartz/dartz.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/failures/trip_failure.dart';
import '../../repositories/trip_repository.dart';
import '../../data/datasources/trip_remote_datasource.dart';
import '../../data/datasources/bag_remote_datasource.dart';

class TripRepositoryImpl implements ITripRepository {
  final TripRemoteDataSource remote;
  final BagRemoteDataSource bagRemote;

  TripRepositoryImpl(this.remote, this.bagRemote);

  @override
  Future<Either<TripFailure, TripEntity>> addTrip({
    required TripEntity trip,
  }) async {
    try {
      final result = await remote.addTrip(trip);
      return Right(result);
    } catch (e) {
      return Left(TripCreateError());
    }
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getAllTrips() async {
    try {
      final result = await remote.getAllTrips();
      return Right(result);
    } catch (e) {
      return Left(TripReadError());
    }
  }

  @override
  Future<Either<TripFailure, TripEntity?>> getTripById({
    required String id,
  }) async {
    try {
      final result = await remote.getTripById(id);
      return Right(result);
    } catch (e) {
      return Left(TripReadError());
    }
  }

  @override
  Future<Either<TripFailure, TripEntity>> updateTrip({
    required TripEntity trip,
  }) async {
    try {
      final result = await remote.updateTrip(trip);
      return Right(result);
    } catch (e) {
      return Left(TripUpdateError());
    }
  }

  @override
  Future<Either<TripFailure, void>> deleteTrip({
    required String id,
  }) async {
    try {
      await remote.deleteTrip(id);
      return const Right(null);
    } catch (e) {
      return Left(TripDeleteError());
    }
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getAllTripsByResponsibleId({
    required String responsibleCollaboratorId,
  }) async {
    try {
      final result =
          await remote.getAllTripsByResponsibleId(responsibleCollaboratorId);
      return Right(result);
    } catch (e) {
      return Left(TripReadError());
    }
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getAllTripsByTraveler({
    required String travelerId,
  }) async {
    try {
      final result = await remote.getAllTripsByTraveler(travelerId);
      return Right(result);
    } catch (e) {
      return Left(TripReadError());
    }
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getTripsById({
    required String tripId,
  }) async {
    try {
      final result = await remote.getTripsById(tripId);
      return Right(result);
    } catch (e) {
      return Left(TripReadError());
    }
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getTripsByStatusAndId({
    required bool? isDone,
    required String travelerId,
  }) async {
    try {
      final result = await remote.getTripsByStatusAndId(isDone, travelerId);

      return Right(result);
    } catch (e) {
      return Left(TripReadError());
    }
  }

  @override
  Future<Either<TripFailure, bool>> isTripDone({
    required String tripId,
  }) async {
    try {
      final result = await remote.isTripDone(tripId);
      return Right(result);
    } catch (e) {
      return Left(TripReadError());
    }
  }

  @override
  Future<Either<TripFailure, BagEntity>> updateBag({
    required BagEntity bag,
  }) async {
    try {
      final result = await bagRemote.updateBag(bag);
      return Right(result);
    } catch (e) {
      return Left(TripUpdateError());
    }
  }

  @override
  Future<Either<TripFailure, List<BagEntity>>> getCurrentTripBagsById({
    required TripEntity trip,
    required String bagId,
  }) async {
    try {
      final result = await bagRemote.getCurrentTripBagsById(trip, bagId);
      return Right(result);
    } catch (e) {
      return Left(TripReadError());
    }
  }
}
