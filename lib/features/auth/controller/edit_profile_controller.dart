import 'package:bag_finder/core/entity/user_entity.dart';
import 'package:bag_finder/core/failures/failure.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../../shared/providers/user_provider.dart';

class EditProfileController with ChangeNotifier {
  final UserProvider _userProvider;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  EditProfileController(this._userProvider);

  Future<Either<Failure, UserEntity>> saveProfile({
    required String fullName,
    required String email,
    required String phone,
    required String cpf,
    required String? newPassword,
  }) async {
    if (_isLoading) {
      return Right(_userProvider.user!); 
    }

    _isLoading = true;
    notifyListeners();

    try {
      final currentUser = _userProvider.user!;
      
      final updatedUser = currentUser.copyWith(
        fullName: fullName,
        email: email,
        phone: phone.isEmpty ? null : phone,
        cpf: cpf,
        
        password: newPassword?.isEmpty == true ? null : newPassword,
      );

      final result = await _userProvider.updateUser(user: updatedUser);

      return result;
      
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}