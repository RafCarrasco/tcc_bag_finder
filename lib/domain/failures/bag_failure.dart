import 'package:tcc_bag_finder/domain/failures/failure.dart';

class BagFailure extends Failure {
  BagFailure({required super.errorMessage});
  static BagFailure invalidStatusTransition() => BagFailure(errorMessage: "Transição de status inválida.");
  static BagFailure cannotBeClaimedYet() => BagFailure(errorMessage: "Bagagem ainda não pode ser retirada.");
}

class BagNotFound extends BagFailure {
  BagNotFound()
      : super(
          errorMessage: "Bagagem não encontrada.",
        );
}

class BagAlreadyExists extends BagFailure {
  BagAlreadyExists()
      : super(
          errorMessage: "Bagagem já existe.",
        );
}

class BagAlreadyAssigned extends BagFailure {
  BagAlreadyAssigned()
      : super(
          errorMessage: "Bagagem já foi atribuída.",
        );
}

class BagNotAssigned extends BagFailure {
  BagNotAssigned()
      : super(
          errorMessage: "Bagagem não foi atribuída.",
        );
}

class BagNotAvailable extends BagFailure {
  BagNotAvailable()
      : super(
          errorMessage: "Bagagem não está disponível.",
        );
}

class BagNotDelivered extends BagFailure {
  BagNotDelivered()
      : super(
          errorMessage: "Bagagem não foi entregue.",
        );
}

class BagAlreadyDelivered extends BagFailure {
  BagAlreadyDelivered()
      : super(
          errorMessage: "Bagagem já foi entregue.",
        );
}

class BagCreateError extends BagFailure {
  BagCreateError()
      : super(
          errorMessage: "Erro ao criar a bagagem.",
        );
}

class BagReadError extends BagFailure {
  BagReadError()
      : super(
          errorMessage: "Erro ao consultar a bagagem.",
        );
}

class BagUpdateError extends BagFailure {
  BagUpdateError()
      : super(
          errorMessage: "Erro ao atualizar a bagagem.",
        );
}

class BagDeleteError extends BagFailure {
  BagDeleteError()
      : super(
          errorMessage: "Erro ao excluir a bagagem.",
        );
}
