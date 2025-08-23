import 'package:dartz/dartz.dart';
import '../../core/entity/traveler_entity.dart';
import '../../core/failures/failure.dart';
import '../../repositories/traveler_repository.dart';
import '../../data/datasources/traveler_remote_datasource.dart';

class TravelerRepositoryImpl implements ITravelerRepository {
  final TravelerRemoteDataSource remote;

  TravelerRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, TravelerEntity>> addTraveler({required TravelerEntity traveler}) async {
    try {
      final result = await remote.addTraveler(traveler);
      return Right(result);
    } catch (e) {
      return Left(ApplicationExecutionError());
    }
  }

  @override
  Future<Either<Failure, List<TravelerEntity>>> getAllTravelers() async {
    try {
      final result = await remote.getAllTravelers();
      return Right(result);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, TravelerEntity?>> getTravelerById({required String id}) async {
    try {
      final result = await remote.getTravelerById(id);
      return Right(result);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, void>> updateTraveler({required TravelerEntity traveler}) async {
    try {
      await remote.updateTraveler(traveler);
      return const Right(null);
    } catch (e) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTraveler({required String id}) async {
    try {
      await remote.deleteTraveler(id);
      return const Right(null);
    } catch (e) {
      return Left(UnknownError());
    }
  }
}
