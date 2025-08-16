class LuggageQuantityDropdownController {
  int? value;

  void onChange(int? newValue) {
    value = newValue;
  }

  int? getValue() {
    return value;
  }
}
