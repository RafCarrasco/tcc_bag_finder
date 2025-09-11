
import 'failure.dart';

abstract class AdminFailure extends Failure {
  AdminFailure({required super.errorMessage});
}

class AdminNotFound extends AdminFailure {
  AdminNotFound()
      : super(
          errorMessage: "Administrador não encontrado.",
        );
}

class AdminAlreadyExists extends AdminFailure {
  AdminAlreadyExists()
      : super(
          errorMessage: "Administrador ja cadastrado.",
        );
}

class AdminUpdateError extends AdminFailure {
  AdminUpdateError()
      : super(
          errorMessage: "Erro ao atualizar administrador.",
        );
}

class AdminDeleteError extends AdminFailure {
  AdminDeleteError()
      : super(
          errorMessage: "Erro ao deletar administrador.",
        );
}
