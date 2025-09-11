import 'failure.dart';

abstract class CollaboratorFailure extends Failure {
  CollaboratorFailure({required super.errorMessage});
}

class CollaboratorNotFound extends CollaboratorFailure {
  CollaboratorNotFound()
      : super(errorMessage: "Colaborador não encontrado.");
}

class CollaboratorAlreadyExists extends CollaboratorFailure {
  CollaboratorAlreadyExists()
      : super(errorMessage: "Colaborador já cadastrado.");
}

class CollaboratorCreateError extends CollaboratorFailure {
  CollaboratorCreateError()
      : super(errorMessage: "Erro ao criar colaborador.");
}

class CollaboratorReadError extends CollaboratorFailure {
  CollaboratorReadError()
      : super(errorMessage: "Erro ao buscar colaborador.");
}

class CollaboratorUpdateError extends CollaboratorFailure {
  CollaboratorUpdateError()
      : super(errorMessage: "Erro ao atualizar colaborador.");
}

class CollaboratorDeleteError extends CollaboratorFailure {
  CollaboratorDeleteError()
      : super(errorMessage: "Erro ao deletar colaborador.");
}

class CollaboratorTripsError extends CollaboratorFailure {
  CollaboratorTripsError({String? message})
      : super(errorMessage: message ?? "Erro ao buscar viagens do colaborador.");
}
