import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:tcc_bag_finder/domain/failures/bag_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';


class BagRepositoryFirestore extends IBagRepository {
  final FirebaseFirestore _firestore;

  BagRepositoryFirestore(this._firestore);

  @override
  Future<Either<BagFailure, BagEntity>> addBag({required BagEntity bag}) async {
    try {
      final docRef = _firestore.collection('bags').doc(bag.id);
      final doc = await docRef.get();

      if (doc.exists) return Left(BagAlreadyExists());

      await docRef.set(bag.toMap());
      return Right(bag);
    } catch (e) {
      return Left(BagCreateError());
    }
  }

  @override
  Future<Either<BagFailure, void>> deleteBag({required String bagId}) async {
    try {
      final docRef = _firestore.collection('bags').doc(bagId);
      final doc = await docRef.get();

      if (!doc.exists) return Left(BagNotFound());

      await docRef.delete();
      return const Right(null);
    } catch (_) {
      return Left(BagDeleteError());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getBagsById({required String bagId}) async {
    try {
      final querySnapshot = await _firestore.collection('bags').get();
      final bags = querySnapshot.docs
          .map((doc) => BagEntity.fromMap(doc.data()))
          .where((bag) => bag.id.toLowerCase().contains(bagId.toLowerCase()))
          .toList();

      if (bags.isEmpty) {
        return Left(BagNotFound());
      }
      return Right(bagId.isEmpty ? bags : bags);
    } catch (_) {
      return Left(BagReadError());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getBagsByStatus({required BagStatusEnum status}) async {
    try {
      final querySnapshot = await _firestore
          .collection('bags')
          .where('status', isEqualTo: status.name)
          .get();

      final bags = querySnapshot.docs
          .map((doc) => BagEntity.fromMap(doc.data()))
          .toList();

      return Right(bags);
    } catch (_) {
      return Left(BagReadError());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getBagsByUserId({required String userId}) async {
    try {
      final querySnapshot = await _firestore
          .collection('bags')
          .where('ownerId', isEqualTo: userId)
          .get();

      final bags = querySnapshot.docs
          .map((doc) => BagEntity.fromMap(doc.data()))
          .toList();

      return Right(bags);
    } catch (_) {
      return Left(BagReadError());
    }
  }

  @override
  Future<Either<BagFailure, BagEntity>> updateBag({required BagEntity bag}) async {
    try {
      final docRef = _firestore.collection('bags').doc(bag.id);
      final doc = await docRef.get();

      if (!doc.exists) {
        return Left(BagNotFound());}

      await docRef.set(bag.toMap());
      return Right(bag);
    } catch (_) {
      return Left(BagUpdateError());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getCurrentTripBagsById({
    required TripEntity trip,
    required String bagId,
  }) async {
    try {
      final bags = trip.bags
              ?.where((bag) => bag.id.toLowerCase().startsWith(bagId.toLowerCase()))
              .toList() ??
          [];

      if (bags.isEmpty) return Left(BagNotFound());

      return Right(bagId.isEmpty ? trip.bags! : bags);
    } catch (_) {
      return Left(BagNotFound());
    }
  }

  @override
  Future<Either<BagFailure, List<BagEntity>>> getUserActiveBagsById({
    required String userId,
    required String bagId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('bags')
          .where('ownerId', isEqualTo: userId)
          .where('status', isNotEqualTo: BagStatusEnum.CLAIMED.name)
          .get();

      final bags = querySnapshot.docs
          .map((doc) => BagEntity.fromMap(doc.data()))
          .where((bag) => bag.id.toLowerCase().contains(bagId.toLowerCase()))
          .toList();

      if (bags.isEmpty) return Left(BagNotFound());
      return Right(bags);
    } catch (_) {
      return Left(BagNotAssigned());
    }
  }
}
