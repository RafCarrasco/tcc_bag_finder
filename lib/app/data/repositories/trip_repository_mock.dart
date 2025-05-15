import 'package:tcc_bag_finder/app/data/mock/db/database_mock.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:tcc_bag_finder/domain/failures/trip_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';

class TripRepositoryMock implements ITripRepository {
  final MockDatabase _db;

  TripRepositoryMock(
    this._db,
  );

  @override
  Future<Either<TripFailure, TripEntity>> addTrip({
    required TripEntity trip,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    _db.trips.add(
      trip,
    );

    return Right(
      trip,
    );
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getAllTripsByResponsibleId({
    required String responsibleCollaboratorId,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    List<TripEntity> trips = _db.trips.where(
      (c) {
        return c.responsibleCollaboratorId == responsibleCollaboratorId;
      },
    ).toList();

    if (trips.isEmpty) {
      return Left(
        TripNotFound(),
      );
    }

    return Right(
      trips,
    );
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getAllTripsByTraveler({
    required String travelerId,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    List<TripEntity> trips = _db.trips
        .where(
          (c) => c.travelerEntity.id.toLowerCase().contains(
                travelerId.toLowerCase(),
              ),
        )
        .toList();

    if (trips.isEmpty) {
      return Left(
        TripNotFound(),
      );
    }

    return Right(
      travelerId.isEmpty ? _db.trips : trips,
    );
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getTripsByStatusAndId({
    required String travelerId,
    required bool? isDone,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    if (isDone == null) {
      return Right(
        _db.trips
            .where(
              (c) => c.travelerEntity.id == travelerId,
            )
            .toList(),
      );
    }

    List<TripEntity>? trips = _db.trips
        .where(
          (c) => c.isDone == isDone && c.travelerEntity.id == travelerId,
        )
        .toList();

    return Right(
      travelerId.isEmpty ? [] : trips,
    );
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getTripsById({
    required String tripId,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    List<TripEntity> collaborators = _db.trips
        .toList()
        .where(
          (c) => c.id.toLowerCase().contains(
                tripId.toLowerCase(),
              ),
        )
        .toList();

    if (collaborators.isEmpty) {
      return Left(
        TripNotFound(),
      );
    }

    return Right(
      tripId.isEmpty ? _db.trips.toList() : collaborators,
    );
  }

  @override
  Future<Either<TripFailure, TripEntity>> updateTrip({
    required TripEntity trip,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    TripEntity? oldTrip = _db.trips.firstWhereOrNull(
      (
        u,
      ) {
        return u.id == trip.id;
      },
    );

    if (oldTrip == null) {
      return Left(
        TripNotFound(),
      );
    }

    _db.trips.remove(
      oldTrip,
    );

    _db.trips.add(
      trip,
    );

    return Right(
      trip,
    );
  }

  @override
  Future<Either<TripFailure, bool>> isTripDone({
    required TripEntity trip,
  }) async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    TripEntity? oldTrip = _db.trips.firstWhereOrNull(
      (u) => u.id == trip.id,
    );

    if (oldTrip == null) {
      return Left(
        TripNotFound(),
      );
    }

    bool allBagsClaimed = trip.bags?.every(
          (bag) => bag.status == BagStatusEnum.CLAIMED,
        ) ??
        false;

    if (!allBagsClaimed) {
      return Left(
        TripNotDone(),
      );
    }

    int tripIndex = _db.trips.indexWhere(
      (u) => u.id == trip.id,
    );

    _db.trips[tripIndex] = trip.copyWith(
      isDone: true,
    );

    return const Right(
      true,
    );
  }
}
