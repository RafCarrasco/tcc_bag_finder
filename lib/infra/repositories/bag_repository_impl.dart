import 'package:dartz/dartz.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/entity/bag_status_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/enums/bag_status_enum.dart';
import '../../core/failures/bag_failure.dart';
import '../../repositories/bag_repository.dart';
import '../../data/datasources/bag_remote_datasource.dart';

class BagRepositoryImpl implements IBagRepository {
  final BagRemoteDataSource remote;

  BagRepositoryImpl(this.remote);

  @override
  Future<Either<BagFailure, BagEntity>> addBag({required BagEntity bag}) async {
    try {
      final result = await remote.addBag(bag);
      return Right(result);
    } catch (e) {
      print(e);
      print(bag.toJson());
      return Left(BagCreateError());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getBagsById(
      {required String bagId}) async {
    try {
      final result = await remote.getBagsById(bagId);
      return Right(result);
    } catch (e) {
      return Left(BagReadError());
    }
  }

  @override
  Future<Either<BagFailure, void>> updateBag({required BagEntity bag}) async {
    try {
      await remote.updateBag(bag);
      return const Right(null);
    } catch (e) {
      return Left(BagUpdateError());
    }
  }

  @override
  Future<Either<BagFailure, void>> deleteBag({required String bagId}) async {
    try {
      await remote.deleteBag(bagId);
      return const Right(null);
    } catch (e) {
      return Left(BagDeleteError());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getBagsByUserId(
      {required String userId}) async {
    try {
      final result = await remote.getBagsByUserId(userId);
      return Right(result);
    } catch (e) {
      return Left(BagReadError());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getBagsByStatus(
      {required BagStatusEnum status}) async {
    try {
      final result = await remote.getBagsByStatus(status);
      return Right(result);
    } catch (e) {
      return Left(BagReadError());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getCurrentTripBagsById({
    required TripEntity trip,
    required String bagId,
  }) async {
    try {
      final result = await remote.getCurrentTripBagsById(trip, bagId);
      return Right(result);
    } catch (e) {
      return Left(BagReadError());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getUserActiveBagsById({
    required String userId,
    required String bagId,
  }) async {
    try {
      final result = await remote.getUserActiveBagsById(userId, bagId);
      return Right(result);
    } catch (e) {
      return Left(BagReadError());
    }
  }
    Future<Either<BagFailure, List<BagEntity>>> getBagsByTripId(
    {required String tripId}) async {
    try {
      final result = await remote.getBagsByTripId(tripId);
      return Right(result);
    } catch (e) {
      print(e);
      return Left(BagReadError());
    }
  }
    @override
  Future<Either<BagFailure, List<BagStatusEntity>>> getBagsStatusById(
    {required String userId}) async {
    try {
      final result = await remote.getBagsStatusById(userId);
      return Right(result);
    } catch (e) {
      print(e);
      return Left(BagReadError());
    }
  }
}
