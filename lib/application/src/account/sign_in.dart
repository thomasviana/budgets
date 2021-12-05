import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/account.dart';

@injectable
class SignIn {
  final AuthService _authService;
  SignIn(
    this._authService,
  );

  void assertPasswordConfirmationIsValid(String password, String confirmation) {
    if (PasswordValidator().isConfirmationValid(password, confirmation)) {
      throw InvalidPasswordConfirmationException();
    }
  }

  Future<Either<AuthFailure, Unit>> anonymously() =>
      _authService.signInAnonymously();

  Future<Either<AuthFailure, Unit>> withGoogle() =>
      _authService.signInWithGoogle();

  Future<Either<AuthFailure, Unit>> withFacebook() =>
      _authService.signInWithFacebook();

  Future<Either<AuthFailure, Unit>> withEmailAndPassword(
          EmailAddress email, Password password) =>
      _authService.signInWithEmailAndPassword(
          emailAddress: email, password: password);
}
