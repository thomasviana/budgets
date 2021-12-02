import 'dart:io';

import 'package:budgets/domain/account.dart';
import 'package:budgets/domain/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'user_firebase_prov.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final UserFirebaseProv _userFirebaseProvider;

  AuthServiceImpl(
    this._firebaseAuth,
    this._googleSignIn,
    this._facebookAuth,
    this._userFirebaseProvider,
  );

  UserEntity? _userFromFirebase(User? user) {
    return user == null
        ? null
        : UserEntity(
            id: UniqueId.fromUniqueString(user.uid),
            name: UserName(user.displayName!),
            emailAddress: EmailAddress(user.email!),
            phoneNumber: PhoneNumber(user.phoneNumber!),
            userImage: UserImage(File(user.photoURL!)),
          );
  }

  @override
  Stream<UserEntity?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);

  @override
  Future<Either<AuthFailure, Unit>> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
      return right(unit);
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      final googleAuthentication = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then((value) => right(unit));
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithFacebook() async {
    try {
      final loginResult = await FacebookAuth.instance.login();
      final accessToken = loginResult.accessToken;
      if (accessToken != null) {
        final facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.token);
        return _firebaseAuth
            .signInWithCredential(facebookAuthCredential)
            .then((value) => right(unit));
      } else {
        return left(const AuthFailure.serverError());
      }
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> createUserWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressString = emailAddress.getOrCrash();
    final passwordString = password.getOrCrash();
    try {
      print('doing');
      _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressString,
        password: passwordString,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUser());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressString = emailAddress.getOrCrash();
    final passwordString = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressString,
        password: passwordString,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return left(const AuthFailure.invalidEmailAndPasswordCombination());
        case 'user-not-found':
          return left(const AuthFailure.userNotFound());
        default:
          return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<Option<UserEntity>> getUser() {
    return _userFirebaseProvider.getUser();
  }

  @override
  Future<void> saveUser(UserEntity user, File? imageFile) {
    return _userFirebaseProvider.saveUser(user, imageFile);
  }
}
