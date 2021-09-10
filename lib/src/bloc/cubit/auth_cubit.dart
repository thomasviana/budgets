import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:budgets/src/repository/auth_repository.dart';
import 'package:budgets/src/repository/implementation/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryBase _authRepository;
  late StreamSubscription _authSubscription;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> init() async {
    await Future.delayed(Duration(seconds: 2));
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
  }

  void _authStateChanged(AuthUser? user) {
    user == null ? emit(AuthSignedOut()) : emit(AuthSignedIn(user));
  }

  Future<void> signInAnonymously() =>
      _signIn(_authRepository.signInAnonymously());

  Future<void> signInWithGoogle() =>
      _signIn(_authRepository.signInWithGoogle());

  Future<void> _signIn(Future<AuthUser?> auxUser) async {
    try {
      emit(AuthSigningIn());
      await Future.delayed(Duration(seconds: 5));
      final user = await auxUser;
      if (user == null) {
        print('8');
        emit(AuthError('Unknown error, try again later.'));
      } else {
        emit(AuthSignedIn(user));
        print(user.uid);
      }
    } catch (e) {
      emit(AuthError('Error: ${e.toString()}'));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthSignedOut());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
