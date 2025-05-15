import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/failures/trip_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetTripsByStatusAndIdUsecase {
  Future<Either<TripFailure, List<TripEntity>>> call({
    required String travelerId,
    required bool? isDone,
  });
}

class GetTripsByStatusAndIdUsecase implements IGetTripsByStatusAndIdUsecase {
  final ITripRepository repository;

  GetTripsByStatusAndIdUsecase({
    required this.repository,
  });

  @override
  Future<Either<TripFailure, List<TripEntity>>> call({
    required String travelerId,
    required bool? isDone,
  }) async {
    return await repository.getTripsByStatusAndId(
      travelerId: travelerId,
      isDone: isDone,
    );
  }
}
