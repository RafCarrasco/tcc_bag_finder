mixin ValidationMixin {
  String? validateRequiredField(
      String? value, String fieldName, bool isRequired) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'O campo $fieldName é obrigatório';
    }
    return null;
  }

  String? validateEmail(String value) {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Insira um email válido';
    }
    return null;
  }

  String? validatePassword(String value) {
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    if (!passwordRegExp.hasMatch(value)) {
      return 'A senha deve conter pelo menos 8 caracteres e 1 caractere especial';
    }
    return null;
  }

  String? validateBrazilianPhone(String value) {
    final RegExp phoneRegExp = RegExp(
      r'^\(?[1-9]{2}\)?\s?[9]?[0-9]{4}\-?[0-9]{4}$',
    );
    if (!phoneRegExp.hasMatch(value)) {
      return 'Insira um telefone válido no formato (XX) XXXXX-XXXX ou (XX) XXXX-XXXX';
    }
    return null;
  }

  String? validateFullName(String value) {
    final names = value.trim().split(' ');
    if (names.length < 2) {
      return 'Por favor, insira seu nome completo (nome e sobrenome)';
    }
    return null;
  }

  String? validateCPF(String value) {
    final RegExp cpfRegExp = RegExp(
      r'^\d{3}\.\d{3}\.\d{3}-\d{2}$',
    );
    if (!cpfRegExp.hasMatch(value)) {
      return 'Insira um CPF válido no formato XXX.XXX.XXX-XX';
    }
    return null;
  }

  String? validateBrazilianDate(String value) {
    final RegExp dateRegExp = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$',
    );
    if (!dateRegExp.hasMatch(value)) {
      return 'Insira uma data válida no formato DD/MM/AAAA';
    }
    return null;
  }

  String? validateOnlyLetters(String value) {
    final RegExp lettersRegExp = RegExp(
      r'^[A-Za-zÀ-ú\s]+$',
    );
    if (!lettersRegExp.hasMatch(value)) {
      return 'O campo deve conter apenas letras';
    }
    return null;
  }

  String? validateField(
      String? value, String fieldName, String fieldType, bool isRequired) {
    final requiredError = validateRequiredField(value, fieldName, isRequired);
    if (requiredError != null) {
      return requiredError;
    }

    if (value != null && value.isNotEmpty) {
      switch (fieldType.toLowerCase()) {
        case 'email':
          return validateEmail(value);
        case 'password':
          return validatePassword(value);
        case 'phone':
          return validateBrazilianPhone(value);
        case 'fullname':
          return validateFullName(value);
        case 'cpf':
          return validateCPF(value);
        case 'date':
          return validateBrazilianDate(value);
        case 'letters':
          return validateOnlyLetters(value);
        default:
          return null;
      }
    }

    return null;
  }
}
