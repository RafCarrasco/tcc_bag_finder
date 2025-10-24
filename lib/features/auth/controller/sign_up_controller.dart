import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/entity/traveler_entity.dart';
import '../../../core/utils/global_snackbar.dart';

class SignUpController {
  final UserProvider _provider = Modular.get<UserProvider>();

  String? email;
  String? password;
  String? fullName;
  String? phone;
  String _cpf = '';

  void setPhone(String? value) {
        phone = value;
    }

  void setPassword(String? value) {
        password = value;
    }
    
    void setFullName(String? value) { 
        fullName = value; 
    }
    
    void setEmail(String? value) { 
        email = value; 
    }

  void setCpf(String? cpf) {
    if (cpf == null) return;
    _cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
  }

  String get cpf => _cpf;

  bool areFieldsValid() {
    return email?.isNotEmpty == true &&
        password?.isNotEmpty == true &&
        fullName?.isNotEmpty == true &&
        _cpf.length == 11;
  }

  Future<void> signUp(BuildContext context) async {
    if (!areFieldsValid()) {
      GlobalSnackBar.error(
          'Preencha todos os campos obrigatórios (CPF deve ter 11 dígitos).');
      return;
    }

    // final existingUserResult = await _provider.checkIfCpfExists(_cpf);

    // bool isCpfAlreadyRegistered = false;
    // existingUserResult.fold(
    //   (_) {},
    //   (user) {
    //     if (user != null && user.email != email) {
    //       GlobalSnackBar.error('CPF já está registrado em outra conta.');
    //       isCpfAlreadyRegistered = true;
    //     } else if (user != null && user.role == 'TRAVELER') {
    //       GlobalSnackBar.error('CPF já está registrado como viajante.');
    //       isCpfAlreadyRegistered = true;
    //     }
    //   },
    // );

    // if (isCpfAlreadyRegistered) {
    //   return;
    // }

    final newUser = TravelerEntity(
      email: email!,
      fullName: fullName!,
      phone: phone ?? '',
      role: '',
      isActive: true,
      password: password!,
      createdAt: DateTime.now(),
      cpf: _cpf,
    );

    final result = await _provider.updasertUser(user: newUser);

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
