import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInController {
  final FirebaseAuth _auth;

  String? email;
  String? password;
  bool rememberMe = false;

  SignInController(this._auth);

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email!.trim(),
        password: password!.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );
      Modular.to.navigate('/welcome');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Erro ao fazer login')),
      );
    }
  }
}
