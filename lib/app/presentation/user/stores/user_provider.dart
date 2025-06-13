import 'package:tcc_bag_finder/app/data/datasources/bag_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/trip_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/user_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/repositories/user_repository_firestore.dart';
import 'package:tcc_bag_finder/app/events/user_created_event.dart';
import 'package:tcc_bag_finder/app/events/user_deleted_event.dart';
import 'package:tcc_bag_finder/app/events/user_updated_event.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/usecases/user/add_user_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/delete_user_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/get_all_users_by_ids_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/get_user_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/login_user_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/update_user_usecase.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  final ITripLocalDatasource _tripLocalDatasource;
  final IUserLocalDatasource _userLocalDatasource;
  final IBagLocalDatasource _bagLocalDatasource;

  final ILoginUserUsecase _loginUserUsecase;
  final IAddUserUsecase _addUserUsecase;
  final IGetAllUsersByIdsUsecase _getAllUsersByIdsUsecase;
  final IGetUserUsecase _getUserUsecase;
  final IDeleteUserUsecase _deleteUserUsecase;
  final IUpdateUserUsecase _updateUserUsecase;
  final EventBus _eventBus;

  UserProvider(
    this._loginUserUsecase,
    this._addUserUsecase,
    this._getUserUsecase,
    this._updateUserUsecase,
    this._deleteUserUsecase,
    this._eventBus,
    this._getAllUsersByIdsUsecase,
    this._userLocalDatasource,
    this._tripLocalDatasource,
    this._bagLocalDatasource,
  );

  UserEntity? _user;

  UserEntity? get user => _user;

  Future<UserEntity?> getUser({required String userId}) async {
    var result = await _getUserUsecase.call(
      userId: userId,
    );

    result.fold(
      (l) {
        _user = null;
        GlobalSnackBar.error(
          l.errorMessage,
        );
      },
      (r) => _user = r,
    );

    notifyListeners();

    return _user;
  }

  Future<UserEntity?> loginUser({
    required String email,
    required String password,
  }) async {
    var result = await _loginUserUsecase.call(
      email: email,
      password: password,
    );

    result.fold(
      (l) {
        _user = null;
        GlobalSnackBar.error(
          l.errorMessage,
        );
      },
      (r) => _user = r,
    );

    notifyListeners();

    return user;
  }

  Future<UserEntity> createUser({
    required UserEntity user,
    bool isSignUp = false,
  }) async {
    var result = await _addUserUsecase.call(
      user: user,
    );

    result.fold(
      (l) => GlobalSnackBar.error(
        l.errorMessage,
      ),
      (r) {
        if (isSignUp) {
          _user = r;
        }

        _eventBus.fire(
          UserCreatedEvent(
            user: r,
          ),
        );

        GlobalSnackBar.success(
          'Usuário criado com sucesso!',
        );
      },
    );

    notifyListeners();

    return user;
  }
Future<String> createUserAuth({
  required String email,
  required String password,
  bool isSignUp = false,
}) async {
  final userRepositoryFirestore = Modular.get<UserRepositoryFirestore>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await userRepositoryFirestore.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? currentUser = _auth.currentUser;
    return currentUser!.uid;
  } catch (e) {
    print(e);
    return 'Error :${e}';
  }
}


  Future<void> updateUser({
    required UserEntity user,
    bool showSnackBar = true,
  }) async {
    var result = await _updateUserUsecase.call(
      user: user,
    );

    result.fold(
      (l) => GlobalSnackBar.error(
        l.errorMessage,
      ),
      (r) {
        _eventBus.fire(
          UserUpdatedEvent(
            user: r,
          ),
        );

        if (showSnackBar) {
          GlobalSnackBar.success(
            'Usuário atualizado com sucesso!',
          );
        }
      },
    );

    notifyListeners();
  }

  Future<void> deleteUser({
    required String id,
  }) async {
    var result = await _deleteUserUsecase.call(
      id: id,
    );

    result.fold(
      (l) => GlobalSnackBar.error(
        l.errorMessage,
      ),
      (r) {
        _eventBus.fire(
          UserDeletedEvent(
            id: id,
          ),
        );
        GlobalSnackBar.success(
          '  Usuário deletado com sucesso!',
        );
      },
    );

    notifyListeners();
  }

  Future<List<String>> getAllUsersNamesByIds({
    required List<String> ids,
  }) async {
    List<String> names = [];
    var result = await _getAllUsersByIdsUsecase.call(collaboratorIds: ids);

    result.fold(
      (l) => GlobalSnackBar.error(
        l.errorMessage,
      ),
      (r) {
        names = r;
      },
    );

    notifyListeners();

    return names;
  }

  void logout() {
    _user = null;
    Modular.to.navigate('/login/sign-in');
  }
}
