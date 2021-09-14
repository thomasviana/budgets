import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  final String? email;
  final String? image;

  AuthUser(this.uid, this.email, this.image);

  @override
  List<Object?> get props => [uid];
}

abstract class AuthRepositoryBase {
  Stream<AuthUser?> get onAuthStateChanged;
  Future<AuthUser?> signInAnonymously();
  Future<AuthUser?> signInWithGoogle();
  Future<AuthUser?> signInWithFacebook();
  Future<AuthUser?> createUserWithEmailAndPassword(
      String email, String password);
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}
