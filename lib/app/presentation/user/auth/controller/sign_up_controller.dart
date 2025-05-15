class SignUpController {
  String? email;
  String? password;
  String? fullName;

  void setEmail(String? value) {
    email = value;
  }

  void setPassword(String? value) {
    password = value;
  }

  void setFullName(String? value) {
    fullName = value;
  }

  void resetFields() {
    email = null;
    password = null;
    fullName = null;
  }

  bool areFieldsValid() {
    return email != null && password != null && fullName != null;
  }
}
