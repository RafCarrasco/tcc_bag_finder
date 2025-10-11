// Place this, for instance, in a new file named 'authentication_exceptions.dart' 
// or near your Failure classes.

class AuthenticationFailedException implements Exception {
  final String message = 'Invalid credentials provided.';

  
  @override
  String toString() => 'AuthenticationFailedException: $message';
}

class UserAlreadyInUseException implements Exception {
  final String message;
  
  UserAlreadyInUseException([this.message = 'CPF or Email already in use.']);

  @override
  String toString() => 'UserAlreadyInUseException: $message';
}