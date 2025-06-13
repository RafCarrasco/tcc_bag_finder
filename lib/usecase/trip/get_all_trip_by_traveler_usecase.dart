import 'package:dartz/dartz.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/trip_failure.dart';
import '../../repositories/trip_repository.dart';

abstract class IGetAllTripsByTravelerIdUsecase {
  Future<Either<TripFailure, List<TripEntity>>> call({
    required String travelerId,
  });
}

class GetAllTripsByTravelerIdUsecase
    implements IGetAllTripsByTravelerIdUsecase {
  final ITripRepository repository;

  GetAllTripsByTravelerIdUsecase({
    required this.repository,
  });

  @override
  Future<Either<TripFailure, List<TripEntity>>> call({
    required String travelerId,
  }) async {
    return await repository.getAllTripsByTraveler(
      travelerId: travelerId,
    );
  }
}
