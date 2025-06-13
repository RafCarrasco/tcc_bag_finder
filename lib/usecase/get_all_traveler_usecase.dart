import 'package:dartz/dartz.dart';
import '../core/entity/traveler_entity.dart';
import '../core/failures/failure.dart';
import '../repositories/traveler_repository.dart';

abstract class IGetAllTravelerUsecase {
  Future<Either<Failure, List<TravelerEntity>>> call();
}

class GetTravelerUsecase implements IGetAllTravelerUsecase {
  final ITravelerRepository repository;

  GetTravelerUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<TravelerEntity>>> call() async {
    return await repository.getAllTravelers();
  }
}
