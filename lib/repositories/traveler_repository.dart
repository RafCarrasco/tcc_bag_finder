import 'package:dartz/dartz.dart';
import '../core/entity/traveler_entity.dart';
import '../core/failures/failure.dart';

abstract class ITravelerRepository {
  Future<Either<Failure, List<TravelerEntity>>> getAllTravelers();
}

