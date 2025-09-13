abstract class Failure implements Exception {
  final String errorMessage;
  final StackTrace? stackTrace;

  Failure({
    required this.errorMessage,
    this.stackTrace,
  });

  @override
  String toString() => errorMessage;
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
  UnknownError({
    StackTrace? stackTrace,
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

class PermissionDeniedError extends Failure {
  PermissionDeniedError()
      : super(
          errorMessage: 'Permissão negada. Verifique as permissões do aplicativo',
        );
}

class RequestTimeoutError extends Failure {
  RequestTimeoutError()
      : super(
          errorMessage: 'O tempo de requisição expirou. Tente novamente',
        );
}
