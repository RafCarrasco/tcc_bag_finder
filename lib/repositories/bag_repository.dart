import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:bag_finder/shared/providers/bag_status_provider.dart';
import 'package:dartz/dartz.dart';

import '../core/entity/bag_entity.dart';
import '../core/entity/trip_entity.dart';
import '../core/enums/bag_status_enum.dart';
import '../core/failures/bag_failure.dart';

abstract class IBagRepository {
  Future<Either<BagFailure, BagEntity>> addBag({
    required BagEntity bag,
  });

  Future<Either<BagFailure, List<BagEntity>>> getBagsByEPC({
    required String epc,
  });

  Future<Either<BagFailure, List<BagEntity>>> getBagsById({
    required String bagId,
  });

  Future<void> updateBag({
    required String bag,
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

  Future<Either<BagFailure, List<BagEntity>>> getBagsByTripId({
    required String tripId,
  });
  
  Future<Either<BagFailure, List<BagStatusEntity>>> getBagsStatusById({
    required String userId,
  });

  Future<Either<BagFailure, List<BagStatusEntity>>> getBagsStatusByPrinted({
    required String printed,
    required String userId
  });
    Future<Either<BagFailure, String?>> getBagIdByEpcAndUser({
    required String epc,
    required String userId,
  });
}
