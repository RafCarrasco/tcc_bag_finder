import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'dart:math';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:tcc_bag_finder/domain/failures/trip_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:tcc_bag_finder/domain/entity/trip_description_entity.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';

class TripRepositoryFirestore implements ITripRepository {
  final FirebaseFirestore _firestore;

  TripRepositoryFirestore(this._firestore);

  CollectionReference get _collection => _firestore.collection('trips');

  @override
  Future<Either<TripFailure, TripEntity>> addTrip({
    required TripEntity trip,
  }) async {
    try {
      final docRef = _collection.doc(trip.id);
      await docRef.set(trip.toMap());
      return Right(trip);
    } catch (_) {
      return Left(TripCreateError());
    }
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getAllTripsByResponsibleId({
    required String responsibleCollaboratorId,
  }) async {
    try {
      final querySnapshot = await _collection
          .where('responsibleCollaboratorId', isEqualTo: responsibleCollaboratorId)
          .get();

      final trips = querySnapshot.docs
          .map((doc) => TripEntity.fromMap(doc.data() as Map<String, dynamic>, id: doc.id))
          .toList();

      if (trips.isEmpty) return Left(TripNotFound());
      return Right(trips);
    } catch (_) {
      return Left(TripReadError());
    }
  }

  @override
  Future<Either<TripFailure, List<TripEntity>>> getAllTripsByTraveler({
    required String travelerId,
  }) async {
    try {
      final querySnapshot = await _collection.get();

      final trips = querySnapshot.docs
          .map((doc) => TripEntity.fromMap(doc.data() as Map<String, dynamic>, id: doc.id))
          .where((trip) => trip.travelerEntity.id.toLowerCase().contains(travelerId.toLowerCase()))
          .toList();

      if (trips.isEmpty) return Left(TripNotFound());
      return Right(travelerId.isEmpty ? trips : trips);
    } catch (_) {
      return Left(TripReadError());
    }
  }

@override
Future<Either<TripFailure, List<TripEntity>>> getTripsByStatusAndId({
  required String travelerId,
  required bool? isDone,
  int numeroBags = 0,
  List<BagEntity> listBags = const <BagEntity>[],
}) async {
  try {
    final querySnapshot = await _collection.get();

    final trips = await Future.wait(
      querySnapshot.docs.map((doc) async {
        final map = doc.data() as Map<String, dynamic>;
        final travelerDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(travelerId) 
            .get();

        final tripsDoc = await FirebaseFirestore.instance
            .collection('trips')
            .doc(travelerId) 
            .get();

        final bagIds = tripsDoc.data()?['bags'] as List<dynamic>? ?? [];
        for (int i = 0; i < bagIds.length; i++) {
          try {
            final bagDoc = await FirebaseFirestore.instance
              .collection('bags')
              .doc(bagIds[i].toString()) // Converte para string para garantir
              .get();

            if (bagDoc.exists) {
              final data = bagDoc.data()!;
              listBags.add(BagEntity(
                ownerId: data['ownerId']?.toString() ?? '',
                description: data['description']?.toString() ?? '',
                status: data['status'],
                id: bagDoc.id, // Melhor usar o ID real do documento
              ));
              print('Bag adicionada: ${bagDoc.id}');
            } else {
              print('Bag não encontrada: ${bagIds[i]}');
            }
          } catch (e) {
            print('Erro ao processar bag ${bagIds[i]}: $e');
          }
          print('--------------------------');
        }
        print('------------------2');
        final travelerEntity = travelerDoc.exists && 
            travelerDoc.data()?['type'] == 'Traveler'
          ? TravelerEntity.fromMap(travelerDoc.data()!)
          : throw Exception('Traveler não encontrado ou tipo inválido');
        return TripEntity(
          id: doc.id,
          responsibleCollaboratorId: map['responsibleCollaboratorId'] ?? '',
          description: TripDescriptionEntity.fromMap(map['description']),
          isDone: map['isDone'] ?? false,
          bags: listBags,
          travelerEntity: travelerEntity,
          createdAt: (map['createdAt'] as Timestamp).toDate(),
          updatedAt: map['updatedAt'] != null
            ? (map['updatedAt'] as Timestamp).toDate()
            : null,
        );
      }),
    );
final filteredTrips = trips.where((trip) {
  return isDone == null || trip.isDone == isDone;
}).toList();
    return Right(filteredTrips);
  } on FirebaseException catch (e) {
    print('Erro no Firestore: ${e.message}');
    return Left(TripReadError());
  } catch (e) {
    print('Erro ao buscar trips: $e');
    return Left(TripReadError());
  }
}


  @override
  Future<Either<TripFailure, List<TripEntity>>> getTripsById({
    required String tripId,
  }) async {
    try {
      final querySnapshot = await _collection.get();

      final trips = querySnapshot.docs
          .map((doc) => TripEntity.fromMap(doc.data() as Map<String, dynamic>, id: doc.id))
          .where((trip) => trip.id.toLowerCase().contains(tripId.toLowerCase()))
          .toList();

      if (trips.isEmpty) return Left(TripNotFound());
      return Right(tripId.isEmpty ? trips : trips);
    } catch (_) {
      return Left(TripReadError());
    }
  }

  @override
  Future<Either<TripFailure, TripEntity>> updateTrip({
    required TripEntity trip,
  }) async {
    try {
      final docRef = _collection.doc(trip.id);
      final doc = await docRef.get();

      if (!doc.exists) return Left(TripNotFound());

      await docRef.set(trip.toMap());
      return Right(trip);
    } catch (_) {
      return Left(TripUpdateError());
    }
  }

  @override
  Future<Either<TripFailure, bool>> isTripDone({
    required TripEntity trip,
  }) async {
    try {
      final allBagsClaimed = trip.bags?.every((bag) => bag.status == BagStatusEnum.CLAIMED) ?? false;
      if (!allBagsClaimed) {
        return Left(TripNotDone());
      }
      final docRef = _collection.doc(trip.id);
      await docRef.update({'isDone': true});
      return const Right(true);
    } catch (_) {
      return Left(TripUpdateError());
    }
  }
}
