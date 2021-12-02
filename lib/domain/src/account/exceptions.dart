class UnknownLoginException implements Exception {}

class InvalidPasswordConfirmationException implements Exception {
  @override
  String toString() => 'The password confirmation is invalid';
}
