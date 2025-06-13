import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/utils/global_snackbar.dart';
import '../../events/user_deleted_event.dart';
import '../../events/user_updated_event.dart';
import '../../usecase/delete_user_usecase.dart';
import '../../usecase/update_user_usecase.dart';
import '../entity/user_entity.dart';

class UserProvider extends ChangeNotifier {
  final IUpdateUserUsecase _updateUserUsecase;
  final IDeleteUserUsecase _deleteUserUsecase;
  final EventBus _eventBus = Modular.get<EventBus>();

  UserProvider(
    this._updateUserUsecase,
    this._deleteUserUsecase,
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserEntity? _user;
  UserEntity? get user => _user;

  Future<UserEntity?> registerNewUser({
    required UserEntity user,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      final newUser = user.copyWith(id: credential.user!.uid);
      await saveUserToFirestore(newUser);

      return newUser;
    } catch (e) {
      GlobalSnackBar.error('Erro ao registrar novo usuário: $e');
      return null;
    }
  }

  Future<void> createUser(UserEntity user) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception('Usuário não autenticado');

      final userWithId = user.copyWith(id: uid);
      await saveUserToFirestore(userWithId);
      _user = userWithId;
      notifyListeners();
    } catch (e) {
      GlobalSnackBar.error('Erro ao criar usuário: $e');
    }
  }

  Future<Map<String, String>> getAllUsersNamesByIds(List<String> userIds) async {
  final Map<String, String> result = {};

  try {
    final snapshot = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: userIds)
        .get();

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final name = data['fullName'] ?? '';
      result[doc.id] = name;
    }
  } catch (e) {
    GlobalSnackBar.error('Erro ao buscar nomes de usuários: $e');
  }

  return result;
}


  Future<UserEntity?> getUser({required String userId}) async {
  try {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return null;

    return UserEntity.fromJson(doc.data()!);
  } catch (e) {
    GlobalSnackBar.error('Erro ao buscar usuário: $e');
    return null;
  }
}


  Future<void> saveUserToFirestore(UserEntity user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      GlobalSnackBar.error('Erro ao salvar usuário no Firestore: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      GlobalSnackBar.error('Erro ao fazer logout: $e');
    }
  }

  Future<void> updateUser({
    required UserEntity user,
    bool showSnackBar = true,
  }) async {
    var result = await _updateUserUsecase.call(user: user);

    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) {
        _user = r;
        _eventBus.fire(UserUpdatedEvent(user: r));
        if (showSnackBar) {
          GlobalSnackBar.success('Usuário atualizado com sucesso!');
        }
      },
    );

    notifyListeners();
  }

  Future<void> deleteUser({required String id}) async {
    var result = await _deleteUserUsecase.call(id: id);

    result.fold(
      (l) => GlobalSnackBar.error(l.errorMessage),
      (r) {
        _user = null;
        _eventBus.fire(UserDeletedEvent(id: id));
        GlobalSnackBar.success('Usuário deletado com sucesso!');
      },
    );

    notifyListeners();
  }
}
