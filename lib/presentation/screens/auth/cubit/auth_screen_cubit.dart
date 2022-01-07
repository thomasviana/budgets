import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

part 'auth_screen_state.dart';

@injectable
class AuthScreenCubit extends Cubit<AuthScreenState> {
  SignIn signIn;
  CreateAccount createAccount;
  CheckAuthStatus checkAuthStatus;

  AuthScreenCubit(
    this.signIn,
    this.createAccount,
    this.checkAuthStatus,
  ) : super(AuthScreenState.initial());

  Future<void> reset() async => emit(AuthScreenState.initial());

  void onEmailChanged(String emailAddress) => emit(
        state.copyWith(
          emailAddress: EmailAddress(emailAddress),
          authFailureOrSuccessOption: none(),
        ),
      );

  void onPasswordChanged(String password) => emit(
        state.copyWith(
          password: Password(password),
          authFailureOrSuccessOption: none(),
        ),
      );

  void onConfirmationPasswordChanged(String confirmationPassword) => emit(
        state.copyWith(
          confirmationPassword: Password(confirmationPassword),
          authFailureOrSuccessOption: none(),
        ),
      );

  Future<void> onSignInAnonymously() async {
    emit(
      state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ),
    );
    final failureOrSuccess = await signIn.anonymously();
    emit(
      state.copyWith(
        isSubmitting: false,
        authFailureOrSuccessOption: some(failureOrSuccess),
      ),
    );
  }

  Future<void> onSignInWithGoogle() async {
    emit(
      state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ),
    );
    final failureOrSuccess = await signIn.withGoogle();
    emit(
      state.copyWith(
        isSubmitting: false,
        authFailureOrSuccessOption: some(failureOrSuccess),
      ),
    );
  }

  Future<void> onSignInWithFacebook() async {
    emit(
      state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ),
    );
    final failureOrSuccess = await signIn.withFacebook();
    emit(
      state.copyWith(
        isSubmitting: false,
        authFailureOrSuccessOption: some(failureOrSuccess),
      ),
    );
  }

  Future<void> onCreateUserWithEmailAndPassword() async {
    final isEmailValid = state.emailAddress.isValid;
    final isPasswordSecure = state.password.isSecure;
    final isConifirmationPasswordMatched =
        state.password == state.confirmationPassword;

    if (isEmailValid && isPasswordSecure && isConifirmationPasswordMatched) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );
      final failureOrSuccess =
          await createAccount(state.emailAddress, state.password);

      emit(
        state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess),
        ),
      );
    }

    emit(
      state.copyWith(
        showErrorMessages: true,
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  Future<void> onSignInWithEmailAndPassword() async {
    final isEmailValid = state.emailAddress.isValid;
    final isPasswordSecure = state.password.isSecure;

    if (isEmailValid && isPasswordSecure) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );

      final failureOrSuccess =
          await signIn.withEmailAndPassword(state.emailAddress, state.password);
      emit(
        state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess),
        ),
      );
    }
    emit(
      state.copyWith(
        showErrorMessages: true,
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  void onAuthModeChanged() {
    emit(state.copyWith(isCreateAccountMode: !state.isCreateAccountMode));
  }
}
