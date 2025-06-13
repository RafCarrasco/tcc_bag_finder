import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bag_finder/domain/entity/admin_entity.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:tcc_bag_finder/domain/failures/auth_failure.dart';
import 'package:tcc_bag_finder/domain/failures/collaborator_failure.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

class UnexpectedAuthFailure extends AuthFailure {
  final e;
  UnexpectedAuthFailure(this.e) : super(errorMessage: 'Falha ao conectar ao db de usuarios:' + e);
}

class UserRepositoryFirestore implements IUserRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserRepositoryFirestore(this.firestore);

  CollectionReference get usersRef => firestore.collection('users');

  DateTime? _parseDate(dynamic date) {
    if (date == null) return null;
    if (date is Timestamp) return date.toDate();
    if (date is DateTime) return date;
    if (date is String) return DateTime.parse(date);
    throw FormatException('Formato de data inválido');
  }

  @override
  Future<Either<AuthFailure, UserEntity>> addUser({
    required UserEntity user,
  }) async {
    try {
      final existing = await usersRef.where('email', isEqualTo: user.email).get();
      if (existing.docs.isNotEmpty) return Left(UserAlreadyInUse());

      await usersRef.doc(user.id).set(user.toMap());
      return Right(user);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> authenticateUser({
    required String email,
    required String password,
  }) async {
    try {
      final snapshot = await usersRef.where('email', isEqualTo: email).get();
      if (snapshot.docs.isEmpty) return Left(UserNotFound());
      
      final doc = snapshot.docs.first;
      final data = doc.data() as Map<String, dynamic>;

      final storedPassword = data['password'] as String?;
      if (storedPassword != password) return Left(InvalidPassword());

      final role = UserRoleEnum.values.firstWhere(
        (r) => r.name == (data['role'] as String? ?? 'TRAVELER'),
        orElse: () => UserRoleEnum.TRAVELER,
      );

      final base = switch (role) {
        UserRoleEnum.ADMIN => AdminEntity(
            id: doc.id,
            email: email,
            password: password,
            fullName: data['fullName'] as String? ?? '',
            phone: data['phone'] as String? ?? '',
            cpf: data['cpf'] as String? ?? '',
            createdAt: _parseDate(data['createdAt']) ?? DateTime.now(),
            updatedAt: _parseDate(data['updatedAt']),
            company: data['company'] as String? ?? '',
          ),
        UserRoleEnum.COLLABORATOR => CollaboratorEntity(
            id: doc.id,
            email: email,
            password: password,
            fullName: data['fullName'] as String? ?? '',
            phone: data['phone'] as String? ?? '',
            cpf: data['phone'] as String? ?? '',
            createdAt: _parseDate(data['createdAt']) ?? DateTime.now(),
            updatedAt: _parseDate(data['updatedAt']),
            company: data['company'] as String? ?? '',
            responsibleId: data['responsibleId'] as String? ?? '',
          ),
        UserRoleEnum.TRAVELER => TravelerEntity(
            id: doc.id,
            email: email,
            password: password,
            fullName: data['fullName'] as String? ?? '',
            phone: data['phone'] as String? ?? '',
            cpf: data['cpf'] as String? ?? '',
            createdAt: _parseDate(data['createdAt']) ?? DateTime.now(),
            updatedAt: _parseDate(data['updatedAt']),
          ),
        UserRoleEnum.OTHER => throw Exception('Tipo de usuário não permitido'),
      };

      return Right(base);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> deleteUser({required String id}) async {
    try {
      final doc = await usersRef.doc(id).get();
      if (!doc.exists) return Left(UserNotFound());

      final user = UserEntity.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
      await usersRef.doc(id).delete();
      return Right(user);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final snapshot = await usersRef.get();
      final users = snapshot.docs.map((doc) {
        return UserEntity.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
      }).toList();
      return Right(users);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserByEmail({required String email}) async {
    try {
      final snapshot = await usersRef.where('email', isEqualTo: email).get();
      if (snapshot.docs.isEmpty) return Left(UserNotFound());

      final doc = snapshot.docs.first;
      final user = UserEntity.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
      return Right(user);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserById({required String id}) async {
    try {
      final doc = await usersRef.doc(id).get();
      if (!doc.exists) return Left(UserNotFound());

      final user = UserEntity.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
      return Right(user);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser({required UserEntity user}) async {
    try {
      final doc = await usersRef.doc(user.id).get();
      if (!doc.exists) return Left(UserNotFound());

      await usersRef.doc(user.id).set(user.toMap());
      return Right(user);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllUsersByIds({List<String>? ids}) async {
    try {
      if (ids == null || ids.isEmpty) return Right([]);
      final snapshot = await usersRef.where(FieldPath.documentId, whereIn: ids).get();
      final names = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['fullName'] as String)
          .toList();
      return names.isEmpty ? Left(UserNotFound()) : Right(names);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersByName({required String name}) async {

    try {
      final snapshot = await usersRef.get();
      final collaborators = snapshot.docs
          .map((doc) => CollaboratorEntity.fromMap(doc.data() as Map<String, dynamic>, id: doc.id))
          .where((c) => c.fullName.toLowerCase().contains(name.toLowerCase()))
          .toList();
      return collaborators.isEmpty
          ? Left(CollaboratorNotFound())
          : Right(name.isEmpty
              ? snapshot.docs
                  .map((doc) => CollaboratorEntity.fromMap(doc.data() as Map<String, dynamic>, id: doc.id))
                  .toList()
              : collaborators);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e));
    }
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Erro no login: ${e.code} - ${e.message}');
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Erro no registro: ${e.code} - ${e.message}');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
