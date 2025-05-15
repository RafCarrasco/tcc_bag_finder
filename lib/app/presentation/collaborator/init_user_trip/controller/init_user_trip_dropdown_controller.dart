import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';

class InitUserTripDropdownController {
  TravelerEntity? value;

  void onChange(
    TravelerEntity? newValue,
  ) {
    value = newValue;
  }

  TravelerEntity? getValue() {
    return value;
  }
}
