import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateUser {
  final AuthService _authService;
  CreateUser(
    this._authService,
  );

  Future<Either<AuthFailure, Unit>> call(
    EmailAddress email,
    Password password,
  ) =>
      _authService.createUserWithEmailAndPassword(
        emailAddress: email,
        password: password,
      );
}
