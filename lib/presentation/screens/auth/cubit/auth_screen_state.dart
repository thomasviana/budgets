part of 'auth_screen_cubit.dart';

class AuthScreenState {
  final EmailAddress emailAddress;
  final Password password;
  final Password confirmationPassword;
  final bool showErrorMessages;
  final bool isSubmitting;
  final bool isCreateAccountMode;
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption;

  AuthScreenState({
    required this.emailAddress,
    required this.password,
    required this.confirmationPassword,
    required this.showErrorMessages,
    required this.isSubmitting,
    required this.isCreateAccountMode,
    required this.authFailureOrSuccessOption,
  });

  factory AuthScreenState.initial() => AuthScreenState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        confirmationPassword: Password(''),
        showErrorMessages: false,
        isSubmitting: false,
        isCreateAccountMode: false,
        authFailureOrSuccessOption: none(),
      );

  AuthScreenState copyWith({
    EmailAddress? emailAddress,
    Password? password,
    Password? confirmationPassword,
    bool? showErrorMessages,
    bool? isSubmitting,
    bool? isCreateAccountMode,
    Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption,
  }) =>
      AuthScreenState(
        emailAddress: emailAddress ?? this.emailAddress,
        password: password ?? this.password,
        confirmationPassword: confirmationPassword ?? this.confirmationPassword,
        showErrorMessages: showErrorMessages ?? this.showErrorMessages,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isCreateAccountMode: isCreateAccountMode ?? this.isCreateAccountMode,
        authFailureOrSuccessOption:
            authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
      );
}
