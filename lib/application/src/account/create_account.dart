import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/account.dart';

@injectable
class CreateAccount {
  final AuthService _authService;
  CreateAccount(
    this._authService,
  );

  Future<Either<AuthFailure, Unit>> call(
          EmailAddress email, Password password) =>
      _authService.createUserWithEmailAndPassword(
        emailAddress: email,
        password: password,
      );
}
