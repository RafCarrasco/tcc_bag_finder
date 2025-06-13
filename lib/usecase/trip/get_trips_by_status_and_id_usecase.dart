import 'package:dartz/dartz.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/trip_failure.dart';
import '../../repositories/trip_repository.dart';

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
