import 'package:flutter/foundation.dart';

/// Fake TravelerProvider só para evitar erros de import.
/// Vai ser substituído futuramente por controllers + usecases.
class TravelerProvider extends ChangeNotifier {
  // Estado fake só pra ilustrar
  bool _isLoading = false;
  String _travelerName = "Viajante Teste";

  bool get isLoading => _isLoading;
  String get travelerName => _travelerName;

  // Método fake para simular uma ação qualquer
  Future<void> loadTravelerProfile() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _travelerName = "Viajante Fake Atualizado";
    _isLoading = false;
    notifyListeners();
  }
}
