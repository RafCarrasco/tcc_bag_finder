import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/entity/user_entity.dart';
import '../../../core/utils/global_snackbar.dart';

class SignUpController {
  final UserProvider _provider = Modular.get<UserProvider>();

  String? email;
  String? password;
  String? fullName;
  String? phone;
  String? cpf;

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
      GlobalSnackBar.error('Preencha todos os campos.');
      return;
    }

    final newUser = UserEntity(
      id: '',
      email: email!,
      fullName: fullName!,
      phone: phone ?? '',
      role: 'TRAVELER',
      isActive: true,
      cpf: cpf,
      createdAt: DateTime.now(),
    );

    final result = await _provider.addUser(newUser);

    result.fold(
      (failure) {
        GlobalSnackBar.error(failure.errorMessage);
      },
      (user) {
        GlobalSnackBar.success('Cadastro realizado com sucesso!');
        Modular.to.navigate('/traveler/${user.id}/home');
      },
    );
  }
}
