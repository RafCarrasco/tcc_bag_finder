class SignUpController {
  String? cpf;
  String? fullName;
  String? dateOfBirth;
  String? cellPhone;
  String? email;
  String? password;

  void setCpfId(String? value) {
    cpf = value;
  }

  void setFullName(String? value) {
    fullName = value;
  }

  void setCellPhone(String? value) {
    cellPhone = value;
  }

  void setEmail(String? value) {
    email = value;
  }

  void setPassword(String? value) {
    password = value;
  }

  void resetFields() {
    email = null;
    password = null;
    fullName = null;
  }

  bool areFieldsValid() {
    return email != null && password != null && fullName != null;
  }

  void setCPF(String value) {}
}
