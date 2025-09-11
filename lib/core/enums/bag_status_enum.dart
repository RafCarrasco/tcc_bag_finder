enum BagStatusEnum {
  CHECKED_IN,
  IN_TRANSIT,
  ARRIVED,
  READY_FOR_PICKUP,
  CLAIMED,
  LOST,
  UNKNOWN,
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
