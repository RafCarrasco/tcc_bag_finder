import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/traveler_repository.dart';
import 'package:dartz/dartz.dart';

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
