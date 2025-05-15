
class SignInController {
  String? email;
  String? password;
  bool? rememberMe = false;

  void setEmail(String? value) {
    email = value;

  }

  void setPassword(String? value) {
    password = value;
  }

  void setRememberMe(bool? value) {
    rememberMe = value;

  }

  void resetFields() {
    email = null;
    password = null;
    rememberMe = false;
  }

  bool areFieldsValid() {
    return email != null && password != null;
  }
}
