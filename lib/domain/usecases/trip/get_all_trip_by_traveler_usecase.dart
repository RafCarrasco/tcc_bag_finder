import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/failures/trip_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

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
