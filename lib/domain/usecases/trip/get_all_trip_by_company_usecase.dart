import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/failures/trip_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

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
