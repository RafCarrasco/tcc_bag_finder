import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import '../../../core/entity/user_entity.dart';
import '../../../core/failures/failure.dart';
import '../../../infra/repositories/user_repository_impl.dart';

class AuthService extends ChangeNotifier {
  final UserRepositoryImpl repository;

  UserEntity? _user;
  bool _isLoading = false;

  AuthService(this.repository) {
    _restoreSession();
  }

  UserEntity? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> saveUserToStorage(UserEntity user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(user.toJson()));
  }

  Future<void> _restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("user");
    if (jsonString != null) {
      try {
        _user = UserEntity.fromJson(jsonDecode(jsonString));
        notifyListeners();
      } catch (e) {
        debugPrint("Erro ao restaurar usuário: $e");
      }
    }
  }

  Future<void> _clearUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");
  }

  Future<Either<Failure, UserEntity?>> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    final result = await repository.authenticateUser(
      email: email,
      password: password,
    );
    _setLoading(false);

    return result.fold(
      (failure) => Left(failure),
      (user) async {
        if (user != null) {
          _user = user;
          await saveUserToStorage(user);
          notifyListeners();
        }
        return Right(user);
      },
    );
  }

  Future<void> logout() async {
    _user = null;
    await _clearUserFromStorage();
    notifyListeners();
  }
}
