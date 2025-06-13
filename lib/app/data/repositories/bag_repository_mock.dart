import 'package:tcc_bag_finder/app/data/mock/db/database_mock.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';

class BagRepositoryMock extends IBagRepository {
  final MockDatabase _db;
  bool canAdvanceTo(BagStatusEnum current, BagStatusEnum next) {
    const orderedFlow = [
      BagStatusEnum.CHECKED_IN,
      BagStatusEnum.IN_TRANSIT,
      BagStatusEnum.ARRIVED,
      BagStatusEnum.READY_FOR_PICKUP,
      BagStatusEnum.CLAIMED,
    ];

    final currentIndex = orderedFlow.indexOf(current);
    final nextIndex = orderedFlow.indexOf(next);

    // Só permite avançar para o próximo status na ordem
    return nextIndex == currentIndex + 1;
  }

  // Verifica se a bagagem está pronta para ser marcada como retirada
  bool canBeClaimed(BagStatusEnum status) {
    return status == BagStatusEnum.READY_FOR_PICKUP;
  }

  BagRepositoryMock(
    this._db,
  );
  @override
  Future<Either<BagFailure, BagEntity>> addBag({
    required BagEntity bag,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    BagEntity? bagAlreadyExist = _db.bags.firstWhereOrNull(
      (e) => e.id == bag.id,
    );

    if (bagAlreadyExist != null) {
      return Left(
        BagAlreadyExists(),
      );
    }

    _db.bags.add(bag);

    return Right(
      bag,
    );
  }

  @override
  Future<Either<BagFailure, void>> deleteBag({
    required String bagId,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    BagEntity? bagAlreadyExist = _db.bags.firstWhereOrNull(
      (e) => e.id == bagId,
    );

    if (bagAlreadyExist == null) {
      return Left(
        BagNotFound(),
      );
    }

    _db.bags.remove(
      bagAlreadyExist,
    );

    return const Right(
      null,
    );
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getBagsById({
    required String bagId,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    List<BagEntity> bags = _db.bags
        .where(
          (e) => e.id.toLowerCase().contains(
                bagId.toLowerCase(),
              ),
        )
        .toList();

    if (bags.isEmpty) {
      return Left(
        BagNotFound(),
      );
    }

    return Right(
      bagId.isEmpty ? _db.bags : bags,
    );
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getBagsByStatus({
    required BagStatusEnum status,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    List<BagEntity>? bags = _db.bags
        .where(
          (e) => e.status == status,
        )
        .toList();

    return Right(
      bags,
    );
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getBagsByUserId({
    required String userId,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    List<BagEntity>? bags = _db.bags
        .where(
          (e) => e.ownerId == userId,
        )
        .toList();

    return Right(
      bags,
    );
  }

  @override
  Future<Either<BagFailure, BagEntity>> updateBag({
    required BagEntity bag,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final index = _db.bags.indexWhere((e) => e.id == bag.id);
    if (index == -1) return Left(BagNotFound());

    final currentBag = _db.bags[index];

    // 🟡 Verifica se a mudança de status segue o fluxo correto
    if (!canAdvanceTo(currentBag.status, bag.status)) {
      return Left(BagFailure.invalidStatusTransition());
    }

    // 🔒 Garante que só é possível confirmar entrega no status correto
    if (bag.status == BagStatusEnum.CLAIMED && !canBeClaimed(currentBag.status)) {
      return Left(BagFailure.cannotBeClaimedYet());
    }

    _db.bags[index] = bag;
    return Right(bag);
  }

    @override
    Future<Either<BagFailure, List<BagEntity>>> getCurrentTripBagsById({
      required TripEntity trip,
      required String bagId,
    }) async {
      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );

      if (trip.bags == null) {
        return Left(
          BagNotFound(),
        );
      }

    final List<BagEntity> bags = trip.bags!
        .where(
          (e) => e.id.toLowerCase().startsWith(
                bagId.toLowerCase(),
              ),
        )
        .toList();

    if (bags.isEmpty) {
      return Left(
        BagNotFound(),
      );
    }

    return Right(
      bagId.isEmpty ? trip.bags! : bags,
    );
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getUserActiveBagsById({
    required String userId,
    required String bagId,
  }) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final List<BagEntity> bags = _db.bags
        .where(
          (e) =>
              e.ownerId == userId &&
              e.id.toLowerCase().contains(bagId.toLowerCase()) &&
              e.status != BagStatusEnum.CLAIMED,
        )
        .toList();

    if (bags.isEmpty) {
      return Left(
        BagNotFound(),
      );
    }

    return Right(bags);
  }
}
