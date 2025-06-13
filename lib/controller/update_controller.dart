
import '../core/enums/user_gender_enum.dart';

class UpdateController {
  String? email;
  String? fullName;
  String? phone;
  String? date;
  UserGenderEnum? gender;

  void setEmail({
    required String? email,
  }) {
    email = email;
  }

  void setFullName({
    required String? fullName,
  }) {
    fullName = fullName;
  }

  void setPhone({
    required String? phone,
  }) {
    phone = phone;
  }

  void setDate({
    required String? date,
  }) {
    date = date;
  }

  void setGender({
    required UserGenderEnum? gender,
  }) {
    gender = gender;
  }

  void resetFields() {
    email = null;
    gender = null;
    date = null;
    fullName = null;
    phone = null;
  }

  bool areFieldsValid() {
    return email != null &&
        fullName != null &&
        phone != null &&
        date != null &&
        gender != null;
  }
}
