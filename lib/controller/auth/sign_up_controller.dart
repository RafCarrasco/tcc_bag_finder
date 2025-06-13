import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/provider/user_provider.dart';
import '../../core/entity/user_entity.dart';

class SignUpController {
  final FirebaseAuth _auth;
  final UserProvider _provider;

  String? email;
  String? password;
  String? fullName;
  String? phone;
  String? cpf;

  SignUpController(this._auth, this._provider);

  void setEmail(String? value) => email = value;
  void setPassword(String? value) => password = value;
  void setFullName(String? value) => fullName = value;
  void setPhone(String? value) => phone = value;
  void setCpf(String? value) => cpf = value;

  void resetFields() {
    email = null;
    password = null;
    fullName = null;
    phone = null;
    cpf = null;
  }

  bool areFieldsValid() {
    return email?.isNotEmpty == true &&
           password?.isNotEmpty == true &&
           fullName?.isNotEmpty == true &&
           cpf?.isNotEmpty == true;
  }

  Future<void> signUp(BuildContext context) async {
    if (!areFieldsValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email!.trim(),
        password: password!.trim(),
      );

      final uid = userCredential.user!.uid;
      final newUser = UserEntity(
        id: uid,
        email: email!,
        fullName: fullName!,
        phone: phone ?? '',
        role: 'TRAVELER',
        isActive: true,
        cpf: cpf, 
        createdAt: DateTime.now(),
      );

      await _provider.saveUserToFirestore(newUser);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );

      Modular.to.navigate('/traveler/$uid/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Erro ao cadastrar')),
      );
    }
  }
}