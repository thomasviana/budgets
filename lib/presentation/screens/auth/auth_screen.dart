import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import '../../widgets/rounded_button.dart';
import 'components/auth_form.dart';
import 'components/custom_divider.dart';
import 'cubit/auth_screen_cubit.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AuthScreenCubit>();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> trySubmit() async {
      if (cubit.state.isCreateAccountMode) {
        await cubit.onCreateUserWithEmailAndPassword();
      } else {
        await cubit.onSignInWithEmailAndPassword();
      }
    }

    return Scaffold(
      body: BlocConsumer<AuthScreenCubit, AuthScreenState>(
        listener: (context, state) {
          state.authFailureOrSuccessOption.fold(
              () => {},
              (either) => either.fold(
                    (failure) => {
                      FlushbarHelper.createError(
                          message: failure.map(
                        cancelledByUser: (_) => 'Cancelled',
                        serverError: (_) => 'Server Error',
                        userNotFound: (_) => 'User doesn\'t exist',
                        emailAlreadyInUser: (_) => 'Email already in use',
                        invalidEmailAndPasswordCombination: (_) =>
                            'Invalid email and password combination',
                      )).show(context)
                    },
                    (_) => {
                      AppNavigator.navigateToMainPage(context),
                      cubit.checkAuthStatus,
                    },
                  ));
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding + 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.donut_large,
                    size: 150,
                    color: AppColors.accentColor,
                  ),
                  SizedBox(height: 50),
                  Text(
                    state.isCreateAccountMode ? 'Register' : 'Login',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 50),
                  AuthForm(
                    enabled: !state.isSubmitting,
                    errorEnabled: state.showErrorMessages,
                    isCreateAccountMode: state.isCreateAccountMode,
                    onEmailChanged: (email) => cubit.onEmailChanged(email),
                    onPasswordChanged: (password) =>
                        cubit.onPasswordChanged(password),
                    onConfirmationPasswordChanged: (confirmationPassword) =>
                        cubit.onConfirmationPasswordChanged(
                            confirmationPassword),
                  ),
                  SizedBox(height: 30),
                  if (state.isSubmitting)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!state.isSubmitting)
                    RoundedButton(
                      label: state.isCreateAccountMode
                          ? 'Create account'
                          : 'Login',
                      isEnabled: true,
                      onPressed: trySubmit,
                    ),
                  SizedBox(height: 20),
                  CustomDivider(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginButton(
                          imagePath: 'assets/images/google_icon.png',
                          onTap: () => context
                              .read<AuthScreenCubit>()
                              .onSignInWithGoogle()),
                      SizedBox(
                        width: 22,
                      ),
                      LoginButton(
                          imagePath: 'assets/images/facebook_icon.png',
                          onTap: () => context
                              .read<AuthScreenCubit>()
                              .onSignInWithFacebook()),
                      SizedBox(
                        width: 22,
                      ),
                      LoginButton(
                          imagePath: 'assets/images/anonymous_icon.png',
                          onTap: () => context
                              .read<AuthScreenCubit>()
                              .onSignInAnonymously()),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.onAuthModeChanged();
                    },
                    child: Text(state.isCreateAccountMode
                        ? 'Already have an account? Login'
                        : 'Create account'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String? emailValidator(String? value) {
    return cubit.state.emailAddress.value.fold(
      (f) => f.maybeMap(
        empty: (_) => 'This is a required field.',
        invalidEmail: (_) => 'Enter a valid email.',
        orElse: () {},
      ),
      (r) => null,
    );
  }

  String? passwordValidator(String? value) {
    return cubit.state.password.value.fold(
      (f) => f.maybeMap(
        empty: (_) => 'This is a required field.',
        shortPassword: (_) => 'Password must be at least 6 characters long.',
        passwordDoNotMatch: (_) => 'Password do not match.',
        orElse: () {},
      ),
      (r) => null,
    );
  }
}

class LoginButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const LoginButton({
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      elevation: 5,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        // customBorder:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onTap: onTap,
        child: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          backgroundColor: AppColors.backgroundColor,
        ),
      ),
    );
  }
}
