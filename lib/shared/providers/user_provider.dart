import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import '../../core/entity/user_entity.dart';
import '../../core/failures/failure.dart';
import '../../infra/repositories/user_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final UserRepositoryImpl repository;

  UserEntity? _user;
  bool _isLoading = false;

  UserProvider(this.repository){_loadUserFromStorage();}

  UserEntity? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
    Future<void> _saveUserToStorage(UserEntity user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(user.toJson()));
  }

  Future<void> _loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("user");
    if (jsonString != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        _user = UserEntity.fromJson(json);
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
      (user) {
        _user = user;
        _saveUserToStorage(user!);
        notifyListeners();
        return Right(user);
      },
    );
  }

  Future<Either<Failure, UserEntity>> addUser(UserEntity user) async {
    _setLoading(true);
    final result = await repository.addUser(user: user);
    _setLoading(false);
    return result.fold(
      (failure) => Left(failure),
      (created)async {
        _user = created;
        await _saveUserToStorage(created);
        notifyListeners();
        return Right(created);
      },
    );
  }

  Future<UserEntity?> registerNewUser({
    required UserEntity user,
    required String password,
  }) async {
    final result = await repository.addUser(user: user);
    return result.fold(
      (failure) => null,
      (created) async{
        notifyListeners();
        return created;
      },
    );
  }

  Future<Either<Failure, UserEntity>> updateUser({
    required UserEntity user,
  }) async {
    _setLoading(true);
    final result = await repository.updateUser(user: user);
    _setLoading(false);

    return result.fold(
      (failure) => Left(failure),
      (updated) async{
        _user = updated;
        await _saveUserToStorage(updated);
        notifyListeners();
        return Right(updated);
      },
    );
  }

  Future<Either<Failure, UserEntity?>> getUserById(String id) async {
    _setLoading(true);
    final result = await repository.getUserById(id: id);
    _setLoading(false);

    return result.fold(
      (failure) => Left(failure),
      (user)async{
        _user = user;
        await _saveUserToStorage(user!);
        notifyListeners();
        return Right(user);
      },
    );
  }

  Future<UserEntity?> getUser({required String userId}) async {
    final result = await getUserById(userId);
    return result.fold(
      (failure) => null,
      (user) => user,
    );
  }

  void logout() async{
    _user = null;
    await _clearUserFromStorage();
    notifyListeners();
  }

  Future<Map<String, String>> getAllUsersNamesByIds(List<String> ids) async {
    _setLoading(true);
    final result = await repository.getAllUsersByIds(ids: ids);
    _setLoading(false);

    return result.fold(
      (failure) => {},
      (names) {
        
        return Map.fromIterables(ids, names);
      },
    );
  }

  Future<bool> deleteUser({required String id}) async {
    _setLoading(true);
    final result = await repository.deleteUser(id: id);
    _setLoading(false);

    return result.fold(
      (failure) => false,
      (_) async {
        if (_user?.id == id) {
          _user = null;
          await _clearUserFromStorage();
          notifyListeners();
        }
        return true;
      },
    );
  }

Future<Either<Failure, UserEntity?>> checkIfCpfExists(String cpf) async {
  _setLoading(true);
  
  final result = await repository.getUserByCpf(cpf: cpf); 
  
  _setLoading(false);
  return result;
}
}

