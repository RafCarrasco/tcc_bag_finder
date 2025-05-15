// ignore_for_file: constant_identifier_names

enum BagStatusEnum {
  CHECKED_IN, // Quando a bagagem é registrada no guichê
  IN_TRANSIT, // Quando a bagagem está em trânsito (a caminho)
  ARRIVED, // Quando a bagagem chega ao aeroporto de destino
  READY_FOR_PICKUP, // Quando a bagagem está pronta para ser retirada
  CLAIMED, // Quando o passageiro pega a bagagem
  LOST, // Caso a bagagem tenha sido perdida
  UNKNOWN, // Estado desconhecido
}

extension BagStatusEnumExtension on BagStatusEnum {
  String toLiteral() {
    switch (this) {
      case BagStatusEnum.CHECKED_IN:
        return 'Registrada';
      case BagStatusEnum.IN_TRANSIT:
        return 'Em Trânsito';
      case BagStatusEnum.ARRIVED:
        return 'Chegada no Destino';
      case BagStatusEnum.READY_FOR_PICKUP:
        return 'Pronta para Retirada';
      case BagStatusEnum.CLAIMED:
        return 'Retirada';
      case BagStatusEnum.LOST:
        return 'Perdida';
      case BagStatusEnum.UNKNOWN:
        return 'Desconhecido';
    }
  }
}
