import 'package:tcc_bag_finder/app/data/mock/db/database_mock.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/traveler_repository.dart';
import 'package:dartz/dartz.dart';

class TravelerRepositoryMock implements ITravelerRepository {
  final MockDatabase _db;

  TravelerRepositoryMock(
    this._db,
  );

  List<TravelerEntity> get _travelers {
    return _db.users.whereType<TravelerEntity>().toList();
  }

  @override
  Future<Either<Failure, List<TravelerEntity>>> getAllTravelers() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    return Right(
      _travelers,
    );
  }
}
