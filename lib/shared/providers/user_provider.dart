import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import '../../core/entity/user_entity.dart';
import '../../core/failures/failure.dart';
import '../../repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final IUserRepository repository;

  UserEntity? _user;
  bool _isLoading = false;

  UserProvider(this.repository);

  UserEntity? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
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
      (created) {
        _user = created;
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
      (created) {
        _user = created;
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
      (updated) {
        _user = updated;
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
      (user) {
        _user = user;
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

  void logout() {
    _user = null;
    notifyListeners();
  }

  Future<Map<String, String>> getAllUsersNamesByIds(List<String> ids) async {
    _setLoading(true);
    final result = await repository.getAllUsersByIds(ids: ids);
    _setLoading(false);

    return result.fold(
      (failure) => {},
      (users) {
        final names = users.map((u) => u.fullName).toList();
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
      (_) {
        if (_user?.id == id) {
          _user = null;
          notifyListeners();
        }
        return true;
      },
    );
  }
}
