// ignore_for_file: constant_identifier_names

enum BagStatusEnum {
  CHECKED_IN,
  IN_TRANSIT,
  ARRIVED_AT_CONNECTION,
  IN_TRANSIT_CONNECTION,
  ARRIVED,
  READY_FOR_PICKUP, 
  COLLECTED, 
  NAO_CADASTRADA
}


extension BagStatusEnumExtension on BagStatusEnum {
  String toLiteral() {
    switch (this) {
      case BagStatusEnum.CHECKED_IN:
        return 'Registrada';
      case BagStatusEnum.IN_TRANSIT:
        return 'Em Trânsito';
      case BagStatusEnum.ARRIVED_AT_CONNECTION:
        return 'Chegada na Conexão';
      case BagStatusEnum.IN_TRANSIT_CONNECTION:
        return 'Em Trânsito na Conexão';
      case BagStatusEnum.ARRIVED:
        return 'Chegada no Destino';
      case BagStatusEnum.READY_FOR_PICKUP:
        return 'Pronta para Retirada';
      case BagStatusEnum.COLLECTED:
        return 'Coletada';
      case BagStatusEnum.NAO_CADASTRADA:
        return 'Mala Não Cadastrada';
    }
  }
}