import 'failure.dart';

abstract class CollaboratorFailure extends Failure {
  CollaboratorFailure({required super.errorMessage});
}

class CollaboratorNotFound extends CollaboratorFailure {
  CollaboratorNotFound()
      : super(
          errorMessage: "Colaborador não encontrado.",
        );
}

class CollaboratorAlreadyExists extends CollaboratorFailure {
  CollaboratorAlreadyExists()
      : super(
          errorMessage: "Colaborador já cadastrado.",
        );
}

class CollaboratorNotAuthorized extends CollaboratorFailure {
  CollaboratorNotAuthorized()
      : super(
          errorMessage: "Colaborador não autorizado.",
        );
}

class CollaboratorUnauthorized extends CollaboratorFailure {
  CollaboratorUnauthorized()
      : super(
          errorMessage: "Colaborador não autorizado.",
        );
}

class CollaboratorCreateError extends CollaboratorFailure {
  CollaboratorCreateError()
      : super(
          errorMessage: "Erro ao criar o colaborador.",
        );
}

class CollaboratorReadError extends CollaboratorFailure {
  CollaboratorReadError()
      : super(
          errorMessage: "Erro ao consultar o colaborador.",
        );
}

class CollaboratorUpdateError extends CollaboratorFailure {
  CollaboratorUpdateError()
      : super(
          errorMessage: "Erro ao atualizar o colaborador.",
        );
}

class CollaboratorDeleteError extends CollaboratorFailure {
  CollaboratorDeleteError()
      : super(
          errorMessage: "Erro ao excluir o colaborador.",
        );
}
