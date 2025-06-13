
import '../core/entity/traveler_entity.dart';

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
