import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/traveler_repository.dart';

class GenericFailure extends Failure {
  final String message;

  GenericFailure({required this.message}) : super(errorMessage: message);
}

class TravelerRepositoryFirestore implements ITravelerRepository {
  final FirebaseFirestore _firestore;

  TravelerRepositoryFirestore(this._firestore);

  CollectionReference get usersRef => _firestore.collection('users');

@override
  Future<Either<Failure, List<TravelerEntity>>> getAllTravelers() async {
    try {
      // 1. Busca apenas documentos onde type = 'traveler'
      final querySnapshot = await _firestore
          .collection('users')
          .where('type', isEqualTo: 'traveler')
          .get();

      // 2. Converte os documentos em TravelerEntity
      final travelers = querySnapshot.docs
          .map((doc) => TravelerEntity.fromMap(doc.data()))
          .toList();

      return Right(travelers);
    } on FirebaseException catch (e) {
      return Left(GenericFailure(message: 'Falha no Firestore: ${e.message}'));
    } catch (_) {
      return Left(GenericFailure(message: 'Erro desconhecido ao buscar viajantes'));
    }
  }
}