import 'package:dartz/dartz.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/failures/trip_failure.dart';
import '../../repositories/trip_repository.dart';

abstract class IGetAllTripsByResponsibleIdUsecase {
  Future<Either<TripFailure, List<TripEntity>>> call({
    required String responsibleCollaboratorId,
  });
}

class GetAllTripsByResponsibleIdUsecase
    implements IGetAllTripsByResponsibleIdUsecase {
  final ITripRepository repository;

  GetAllTripsByResponsibleIdUsecase({
    required this.repository,
  });

  @override
  Future<Either<TripFailure, List<TripEntity>>> call({
    required String responsibleCollaboratorId,
  }) async {
    return await repository.getAllTripsByResponsibleId(
      responsibleCollaboratorId: responsibleCollaboratorId,
    );
  }
}
