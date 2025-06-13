import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/utils/global_snackbar.dart';

class SignInController {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  String? email;
  String? password;
  bool rememberMe = false;

  SignInController(this._auth, this._firestore);

  void setEmail(String? value) => email = value;
  void setPassword(String? value) => password = value;
  void setRememberMe(bool? value) => rememberMe = value ?? false;

  void resetFields() {
    email = null;
    password = null;
    rememberMe = false;
  }

  bool areFieldsValid() {
    return email?.isNotEmpty == true && password?.isNotEmpty == true;
  }

  Future<void> signIn(BuildContext context) async {
    if (!areFieldsValid()) {
      GlobalSnackBar.error('Preencha todos os campos.');
      return;
    }

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email!.trim(),
        password: password!.trim(),
      );

      final user = userCredential.user;
      if (user == null) {
        GlobalSnackBar.error('Usuário não encontrado.');
        return;
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists || !doc.data()!.containsKey('role')) {
        GlobalSnackBar.error('Informações do usuário incompletas.');
        return;
      }

      final role = doc['role'];
      final route = switch (role.toString().toLowerCase()) {
        'admin' => '/admin/${user.uid}/home',
        'collaborator' => '/collaborator/${user.uid}/home',
        'traveler' => '/traveler/${user.uid}/home',
        _ => '/welcome',
      };

      GlobalSnackBar.success('Login realizado com sucesso!');
      Modular.to.navigate(route);
    } on FirebaseAuthException catch (e) {
      GlobalSnackBar.error(e.message ?? 'Erro ao fazer login.');
    } catch (e) {
      GlobalSnackBar.error('Erro inesperado. Tente novamente.');
    }
  }
}
