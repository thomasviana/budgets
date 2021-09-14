import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:budgets/data/repository/auth_repository.dart';

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

  Future<void> reset() async => emit(AuthInitial());

  void _authStateChanged(AuthUser? user) {
    user == null ? emit(AuthSignedOut()) : emit(AuthSignedIn(user));
  }

  Future<void> signInAnonymously() =>
      _signIn(_authRepository.signInAnonymously());

  Future<void> signInWithGoogle() =>
      _signIn(_authRepository.signInWithGoogle());

  Future<void> signInWithFacebook() =>
      _signIn(_authRepository.signInWithFacebook());

  Future<void> createUserWithEmailAndPassword(String email, String password) =>
      _signIn(_authRepository.createUserWithEmailAndPassword(email, password));

  Future<void> signInWithEmailAndPassword(String email, String password) =>
      _signIn(_authRepository.signInWithEmailAndPassword(email, password));

  Future<void> _signIn(Future<AuthUser?> auxUser) async {
    try {
      emit(AuthSigningIn());
      print('ing');
      await Future.delayed(Duration(seconds: 5));
      final user = await auxUser;
      if (user == null) {
        print('error');
        emit(AuthError('Unknown error, try again later.'));
      } else {
        print('in');
        emit(AuthSignedIn(user));
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
