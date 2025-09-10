import 'failure.dart';

abstract class BagFailure extends Failure {
  BagFailure({required super.errorMessage});
}

class BagNotFound extends BagFailure {
  BagNotFound({String message = "Bagagem não encontrada."})
      : super(errorMessage: message);
}

class BagAlreadyExists extends BagFailure {
  BagAlreadyExists({String message = "Bagagem já existe."})
      : super(errorMessage: message);
}

class BagAlreadyAssigned extends BagFailure {
  BagAlreadyAssigned({String message = "Bagagem já foi atribuída."})
      : super(errorMessage: message);
}

class BagNotAssigned extends BagFailure {
  BagNotAssigned({String message = "Bagagem não foi atribuída."})
      : super(errorMessage: message);
}

class BagNotAvailable extends BagFailure {
  BagNotAvailable({String message = "Bagagem não está disponível."})
      : super(errorMessage: message);
}

class BagNotDelivered extends BagFailure {
  BagNotDelivered({String message = "Bagagem não foi entregue."})
      : super(errorMessage: message);
}

class BagAlreadyDelivered extends BagFailure {
  BagAlreadyDelivered({String message = "Bagagem já foi entregue."})
      : super(errorMessage: message);
}

class BagCreateError extends BagFailure {
  BagCreateError({String message = "Erro ao criar a bagagem."})
      : super(errorMessage: message);
}

class BagReadError extends BagFailure {
  BagReadError({String message = "Erro ao consultar a bagagem."})
      : super(errorMessage: message);
}

class BagUpdateError extends BagFailure {
  BagUpdateError({String message = "Erro ao atualizar a bagagem."})
      : super(errorMessage: message);
}

class BagDeleteError extends BagFailure {
  BagDeleteError({String message = "Erro ao excluir a bagagem."})
      : super(errorMessage: message);
}
