class AddCollaboratorController {
  String? email;
  String? password;
  String? fullName;
  String? phone;

  void setEmail({required String? value}) => email = value;
  void setPhone({required String? value}) => phone = value;
  void setPassword({required String? value}) => password = value;
  void setFullName({required String? value}) => fullName = value;

  void resetFields() {
    email = null;
    password = null;
    fullName = null;
    phone = null;
  }

  bool areFieldsValid() {
    return email?.trim().isNotEmpty == true &&
           password?.trim().isNotEmpty == true &&
           fullName?.trim().isNotEmpty == true &&
           phone?.trim().isNotEmpty == true;
  }
}
