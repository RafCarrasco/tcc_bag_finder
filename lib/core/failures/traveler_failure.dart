import 'failure.dart';

abstract class TravelerFailure extends Failure {
  TravelerFailure({required super.errorMessage});
}

class TravelerNotFound extends TravelerFailure {
  TravelerNotFound()
      : super(
          errorMessage: "Viajante não encontrado.",
        );
}

class TravelerAlreadyExists extends TravelerFailure {
  TravelerAlreadyExists()
      : super(
          errorMessage: "Viajante já cadastrado.",
        );
}

class TravelerCreateError extends TravelerFailure {
  TravelerCreateError()
      : super(
          errorMessage: "Erro ao criar o viajante.",
        );
}

class TravelerReadError extends TravelerFailure {
  TravelerReadError()
      : super(
          errorMessage: "Erro ao consultar o viajante.",
        );
}

class TravelerUpdateError extends TravelerFailure {
  TravelerUpdateError()
      : super(
          errorMessage: "Erro ao atualizar o viajante.",
        );
}

class TravelerDeleteError extends TravelerFailure {
  TravelerDeleteError()
      : super(
          errorMessage: "Erro ao excluir o viajante.",
        );
}
