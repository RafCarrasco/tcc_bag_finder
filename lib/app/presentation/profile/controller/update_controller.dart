import 'package:tcc_bag_finder/domain/enums/user_gender_enum.dart';

class UpdateController {
  String? email;
  String? password;
  String? fullName;
  String? phone;
  String? date;

  void setEmail({
    required String? email,
  }) {
    email = email;
  }
  void setPassword({
    required String? password,
  }) {
    password = password;
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

  void resetFields() {
    email = null;
    password = null;
    date = null;
    fullName = null;
    phone = null;
  }

  bool areFieldsValid() {
    return email != null &&
        fullName != null &&
        phone != null &&
        date != null &&
        password != null;
  }
}
