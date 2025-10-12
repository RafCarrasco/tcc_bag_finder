import 'failure.dart';

abstract class AuthFailure extends Failure {
  AuthFailure({required super.errorMessage});
}

class UserNotFound extends AuthFailure {
  UserNotFound()
      : super(
          errorMessage: "Usuário não encontrado.",
        );
}

class UserAlreadyInUse extends AuthFailure {
  UserAlreadyInUse()
      : super(
          errorMessage: "Usuário em uso.",
        );
}

class EmailAlreadyInUse extends AuthFailure {
  EmailAlreadyInUse()
      : super(
          errorMessage: "Email em uso.",
        );
}

class InvalidPassword extends AuthFailure {
  InvalidPassword()
      : super(
          errorMessage: "Senha inválida.",
        );
}

class PhoneAlreadyInUse extends AuthFailure {
  PhoneAlreadyInUse()
      : super(
          errorMessage: "Telefone em uso.",
        );
}

class InvalidEmail extends AuthFailure {
  InvalidEmail()
      : super(
          errorMessage: "Email inválido.",
        );
}

class ResetPasswordFailure extends AuthFailure {
  ResetPasswordFailure({String errorMessage = "Não foi possível redefinir a senha. Tente novamente."})
      : super(errorMessage: errorMessage);
}

class InvalidCredentials extends AuthFailure {
  InvalidCredentials()
      : super(
            errorMessage:
                "CPF, e-mail ou perfil de usuário inválido para a redefinição de senha. Apenas TRAVELERS podem resetar.");
}


