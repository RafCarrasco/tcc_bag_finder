// ignore_for_file: unused_catch_stack

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/user_repository.dart';
import '../entity/user_entity.dart';
import '../failures/auth_failure.dart';
import '../failures/failure.dart';

class UserRepositoryImpl implements IUserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl({required this.firestore});

  @override
  Future<Either<AuthFailure, UserEntity>> addUser({required UserEntity user}) async {
    try {
      await firestore.collection('users').doc(user.id).set(user.toJson());
      return right(user);
    } catch (e, stack) {
      return left(UserAlreadyInUse());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserById({required String id}) async {
    try {
      final doc = await firestore.collection('users').doc(id).get();
      if (doc.exists) {
        return right(UserEntity.fromJson(doc.data()!));
      } else {
        return right(null);
      }
    } catch (e, stack) {
      return left(UnknownError(stackTrace: stack));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser({required UserEntity user}) async {
    try {
      await firestore.collection('users').doc(user.id).update(user.toJson());
      return right(user);
    } catch (e, stack) {
      return left(UnknownError(stackTrace: stack));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser({required String id}) async {
    try {
      await firestore.collection('users').doc(id).delete();
      return const Right(null);
    } catch (e, stack) {
      return left(UnknownError(stackTrace: stack));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final query = await firestore.collection('users').get();
      final list = query.docs.map((doc) => UserEntity.fromJson(doc.data())).toList();
      return right(list);
    } catch (e, stack) {
      return left(UnknownError(stackTrace: stack));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllUsersByIds({List<String>? ids}) async {
    try {
      if (ids == null || ids.isEmpty) return right([]);
      final snapshots = await Future.wait(
        ids.map((id) => firestore.collection('users').doc(id).get()),
      );
      final result = snapshots
          .where((doc) => doc.exists)
          .map((doc) => doc.get('fullName') as String)
          .toList();
      return right(result);
    } catch (e, stack) {
      return left(UnknownError(stackTrace: stack));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserByEmail({required String email}) async {
    try {
      final query = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        return right(UserEntity.fromJson(query.docs.first.data()));
      } else {
        return left(NoDataFound());
      }
    } catch (e, stack) {
      return left(UnknownError(stackTrace: stack));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersByName({required String name}) async {
    try {
      final query = await firestore
          .collection('users')
          .where('fullName', isGreaterThanOrEqualTo: name)
          .get();

      final users = query.docs.map((doc) => UserEntity.fromJson(doc.data())).toList();
      return right(users);
    } catch (e, stack) {
      return left(UnknownError(stackTrace: stack));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> authenticateUser({
    required String email,
    required String password,
  }) async {
    return left(ApplicationExecutionError());
  }
}
