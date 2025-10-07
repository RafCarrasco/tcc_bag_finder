import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/utils/global_snackbar.dart';
import '../../../shared/providers/user_provider.dart';
import 'auth_controller.dart';

class SignInController {
  final AuthService _authProvider = Modular.get<AuthService>();

  String? email;
  String? password;
  bool rememberMe = false;

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

    final result = await _authProvider.login(
      email: email!.trim(),
      password: password!.trim(),
    );

    result.fold(
      (failure) {
        GlobalSnackBar.error(failure.errorMessage);
      },
      (user) {
        if (user == null) {
          GlobalSnackBar.error('Usuário não encontrado.');
          return;
        }

        final role = user.role.toLowerCase();
        final route = switch (role) {
          'admin' => '/admin/${user.id}/home',
          'collaborator' => '/collaborator/${user.id}/home',
          'traveler' => '/traveler/${user.id}/home',
          _ => '/welcome',
        };

        GlobalSnackBar.success('Login realizado com sucesso!');
        Modular.to.navigate(route);
      },
    );
  }
}
