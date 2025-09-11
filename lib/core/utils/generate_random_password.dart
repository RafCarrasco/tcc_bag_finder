import 'dart:math';

String generateRandomPassword({int length = 12}) {
  const String upperCaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String lowerCaseLetters = 'abcdefghijklmnopqrstuvwxyz';
  const String numbers = '0123456789';
  const String specialCharacters = '!@#\$%^&*()-_=+[]{}|;:<>,.?/';

  const String allCharacters =
      upperCaseLetters + lowerCaseLetters + numbers + specialCharacters;
  final Random random = Random();

  String password = '';
  for (int i = 0; i < length; i++) {
    password += allCharacters[random.nextInt(allCharacters.length)];
  }

  return password;
}
