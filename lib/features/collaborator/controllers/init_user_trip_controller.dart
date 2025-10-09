import 'package:bag_finder/core/entity/tag_entity.dart';

import '../../../core/entity/traveler_entity.dart';

class InitUserTripController {
  String _destination = '';
  String _airportOrigin = '';
  String _airportDestination = '';
  String _cpf = '';
  String? _description = '';
  int? _bagageQuantity = 0;
  TravelerEntity _travelerEntity = TravelerEntity.empty();
  List<String> codeTags = [];

  String get destination => _destination;
  String get airportOrigin => _airportOrigin;
  String get airportDestination => _airportDestination;
  String get cpf => _cpf;
  String? get description => _description;
  int? get bagageQuantity => _bagageQuantity;
  TravelerEntity get user => _travelerEntity;

  void setUser({
    required TravelerEntity? user,
  }) {
    _travelerEntity = user ?? TravelerEntity.empty();
  }

  void setCpf({required String? cpf}) {
    if (cpf == null) return;
    final cleanedCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    _cpf = cleanedCpf;
  }

  void setDescription({
    required String? description,
  }) {
    _description = description;
  }

  void setDestination({
    required String destination,
  }) {
    _destination = destination;
  }

  void setAirportOrigin({
    required String airportOrigin,
  }) {
    _airportOrigin = airportOrigin;
  }

  void setAirportDestination({
    required String airportDestination,
  }) {
    _airportDestination = airportDestination;
  }

  void setBagageQuantity({
    required int? bagageQuantity,
  }) {
    _bagageQuantity = bagageQuantity;
  }

  void clearFields() {
    _destination = '';
    _airportOrigin = '';
    _airportDestination = '';
    _description = '';
    _bagageQuantity = 0;
  }

  void addTagCodeAtIndex(int index, String code) {
    if (code.isEmpty) return;

    if (codeTags.length > index) {
      codeTags[index] = code;
    } else {
      while (codeTags.length <= index) {
        codeTags.add('');
      }
      codeTags[index] = code;
    }
  }
}