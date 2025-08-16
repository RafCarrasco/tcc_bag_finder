import 'package:flutter/foundation.dart';

/// Fake AdminProvider só para evitar erros de import.
/// Vai ser substituído futuramente por controllers + usecases.
class AdminProvider extends ChangeNotifier {
  // Exemplo de estado fake
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Exemplo de método fake
  Future<void> fakeAction() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }
}
