import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';

abstract class Failure implements Exception {
  String errorMessage;

  Failure({
    required this.errorMessage,
    StackTrace? stackTrace,
  }) {
    Modular.get<Logger>().e(
      errorMessage,
      time: DateTime.now(),
      error: this,
      stackTrace: stackTrace,
    );
  }
}

class LocalStorageFailure extends Failure {
  LocalStorageFailure()
      : super(
          errorMessage: 'Falha no armazenamento local',
        );
}

class NoInternetConnectionError extends Failure {
  NoInternetConnectionError()
      : super(
          errorMessage: 'Erro de conexão. Verifique sua rede',
        );
}

class NoDataFound extends Failure {
  NoDataFound()
      : super(
          errorMessage: 'Nenhum dado encontrado',
        );
}

class UnknownError extends Failure {
  final StackTrace? stackTrace;

  UnknownError({
    this.stackTrace,
  }) : super(
          stackTrace: stackTrace,
          errorMessage: 'Falha desconhecida',
        );
}

class ServerStorageFailure extends Failure {
  ServerStorageFailure()
      : super(
          errorMessage: 'Falha ao armazenar dados no servidor',
        );
}

class ApplicationExecutionError extends Failure {
  ApplicationExecutionError()
      : super(
          errorMessage: 'Erro ao executar a aplicação',
        );
}

class ServerError extends Failure {
  ServerError()
      : super(
          errorMessage: 'Erro no servidor. Tente novamente mais tarde',
        );
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure()
      : super(
          errorMessage: 'Erro de autenticação. Verifique suas credenciais',
        );
}

class PermissionDeniedError extends Failure {
  PermissionDeniedError()
      : super(
          errorMessage:
              'Permissão negada. Verifique as permissões do aplicativo',
        );
}

class RequestTimeoutError extends Failure {
  RequestTimeoutError()
      : super(
          errorMessage: 'O tempo de requisição expirou. Tente novamente',
        );
}
