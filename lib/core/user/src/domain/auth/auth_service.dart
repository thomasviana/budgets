import 'package:dartz/dartz.dart';

import 'auth_failure.dart';
import 'user_entity.dart';
import 'value_objects.dart';

abstract class AuthService {
  Future<Either<AuthFailure, Unit>> signInAnonymously();
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<Either<AuthFailure, Unit>> createUserWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<void> logOut();
  Stream<UserEntity?> getUser();
  Future<void> saveUser(UserEntity user);
}
