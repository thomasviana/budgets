import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_repository.dart';

class AuthRepository extends AuthRepositoryBase {
  final _firebaseAuth = FirebaseAuth.instance;

  AuthUser? _userFromFirebase(User? user) {
    return user == null ? null : AuthUser(user.uid, user.email);
  }

  @override
  Stream<AuthUser?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);

  @override
  Future<AuthUser?> signInAnonymously() async {
    final user = await _firebaseAuth.signInAnonymously();
    final result = _userFromFirebase(user.user);
    return result;
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final authResult = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }
}
