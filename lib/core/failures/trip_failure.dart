import 'failure.dart';

abstract class TripFailure extends Failure {
  TripFailure({required super.errorMessage});
}

class TripNotFound extends TripFailure {
  TripNotFound()
      : super(
          errorMessage: "Viagem não encontrada.",
        );
}

class TripAlreadyExists extends TripFailure {
  TripAlreadyExists()
      : super(
          errorMessage: "Viagem já existe.",
        );
}

class TripNotCreated extends TripFailure {
  TripNotCreated()
      : super(
          errorMessage: "Viagem não foi criada.",
        );
}

class TripNotUpdated extends TripFailure {
  TripNotUpdated()
      : super(
          errorMessage: "Viagem não foi atualizada.",
        );
}

class TripNotDeleted extends TripFailure {
  TripNotDeleted()
      : super(
          errorMessage: "Viagem não foi excluída.",
        );
}

class TripNotAdded extends TripFailure {
  TripNotAdded()
      : super(
          errorMessage: "Viagem não foi adicionada.",
        );
}

class TripNotDone extends TripFailure {
  TripNotDone()
      : super(
          errorMessage: "Viagem não foi concluida.",
        );
}

class TripCreateError extends TripFailure {
  TripCreateError()
      : super(
          errorMessage: "Erro ao criar a viagem.",
        );
}

class TripReadError extends TripFailure {
  TripReadError()
      : super(
          errorMessage: "Erro ao consultar a viagem.",
        );
}

class TripUpdateError extends TripFailure {
  TripUpdateError()
      : super(
          errorMessage: "Erro ao atualizar a viagem.",
        );
}

class TripDeleteError extends TripFailure {
  TripDeleteError()
      : super(
          errorMessage: "Erro ao excluir a viagem.",
        );
}
