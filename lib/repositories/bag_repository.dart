import 'package:dartz/dartz.dart';

import '../core/entity/bag_entity.dart';
import '../core/entity/trip_entity.dart';
import '../core/enums/bag_status_enum.dart';
import '../core/failures/bag_failure.dart';

abstract class IBagRepository {
  Future<Either<BagFailure, BagEntity>> addBag({
    required BagEntity bag,
  });

  Future<Either<BagFailure, List<BagEntity>>> getBagsById({
    required String bagId,
  });

  Future<Either<BagFailure, void>> updateBag({
    required BagEntity bag,
  });

  Future<Either<BagFailure, void>> deleteBag({
    required String bagId,
  });

  Future<Either<BagFailure, List<BagEntity>>> getBagsByUserId({
    required String userId,
  });

  Future<Either<BagFailure, List<BagEntity>>> getBagsByStatus({
    required BagStatusEnum status,
  });

  Future<Either<BagFailure, List<BagEntity>>> getCurrentTripBagsById({
    required TripEntity trip,
    required String bagId,
  });

  Future<Either<BagFailure, List<BagEntity>>> getUserActiveBagsById({
    required String userId,
    required String bagId,
  });
}
