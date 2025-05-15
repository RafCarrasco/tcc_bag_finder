class CollaboratorPanelController {
  String _searchValue = "";

  String get searchValue => _searchValue;

  void setSearchValue({
    required String value,
  }) {
    _searchValue = value;
  }
}
