import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/failures/collaborator_failure.dart';
import 'package:tcc_bag_finder/domain/repositories/collaborator_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollaboratorRepositoryFirestore implements ICollaboratorRepository {
  final FirebaseFirestore _firestore;

  CollaboratorRepositoryFirestore(this._firestore);

  @override
  Future<Either<CollaboratorFailure, List<CollaboratorEntity>>>
      getCollaboratorsByResponsibleId({
    required String id,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('responsibleId', isEqualTo: id)
          .get();

      final collaborators = querySnapshot.docs
          .map((doc) => CollaboratorEntity.fromMap(doc.data()))
          .toList();

      if (collaborators.isEmpty) {
        return Left(CollaboratorNotFound());
      }

      return Right(collaborators);
    } catch (_) {
      return Left(CollaboratorReadError());
    }
  }
}
