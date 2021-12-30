import 'package:budgets/presentation/screens/auth/cubit/auth_screen_cubit.dart';
import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

class AuthForm extends StatefulWidget {
  final bool enabled;
  final bool errorEnabled;
  final bool isCreateAccountMode;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onConfirmationPasswordChanged;
  final AuthScreenState state;

  const AuthForm({
    Key? key,
    required this.enabled,
    required this.errorEnabled,
    required this.isCreateAccountMode,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onConfirmationPasswordChanged,
    required this.state,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: widget.errorEnabled
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          TextFormField(
            key: ValueKey('email'),
            cursorColor: AppColors.primaryColor,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
            decoration: InputDecoration(
              hintText: 'Enter email',
              enabled: widget.enabled,
            ),
            onChanged: widget.onEmailChanged,
          ),
          TextFormField(
            key: ValueKey('password'),
            obscureText: !_isPasswordVisible,
            cursorColor: AppColors.primaryColor,
            keyboardType: TextInputType.emailAddress,
            validator: passwordValidator,
            decoration: InputDecoration(
              hintText: 'Enter password',
            ),
            onChanged: widget.onPasswordChanged,
          ),
          if (widget.isCreateAccountMode)
            TextFormField(
              key: ValueKey('confirm_password'),
              obscureText: !_isPasswordVisible,
              cursorColor: AppColors.primaryColor,
              keyboardType: TextInputType.emailAddress,
              validator: passwordConfirmationValidator,
              decoration: InputDecoration(
                hintText: 'Confirm password',
              ),
              onChanged: widget.onConfirmationPasswordChanged,
            ),
        ],
      ),
    );
  }

  String? emailValidator(String? value) {
    if (!widget.state.emailAddress.value.isNotEmpty) {
      return 'This is a required field.';
    } else if (!widget.state.emailAddress.isValid) {
      return 'Enter a valid email.';
    }
    // }
    // // return !cubit.state.emailAddress.isValid ? 'Enter a valid email.' : null;
    // return cubit.state.emailAddress.value.fold(
    //   (f) => f.maybeMap(
    //     empty: (_) => 'This is a required field.',
    //     invalidEmail: (_) => 'Enter a valid email.',
    //     orElse: () {},
    //   ),
    //   (r) => null,
    // );
  }

  String? passwordValidator(String? value) {
    if (!widget.state.password.value.isNotEmpty) {
      return 'This is a required field.';
    } else if (!widget.state.password.isSecure) {
      return 'Password must be at least 6 characters long.';
    }
    //   return cubit.state.password.value.fold(
    //     (f) => f.maybeMap(
    //       empty: (_) => 'This is a required field.',
    //       shortPassword: (_) => 'Password must be at least 6 characters long.
    //       passwordDoNotMatch: (_) => 'Password do not match.',
    //       orElse: () {},
    //     ),
    //     (r) => null,
    //   );
    // }
  }

  String? passwordConfirmationValidator(String? value) {
    if (!widget.state.password.value.isNotEmpty) {
      return 'This is a required field.';
    }
    if (widget.state.isCreateAccountMode) {
      if (!widget.state.password.isSecure) {
        return 'Password must be at least 6 characters long.';
      }
    }

    // return widget.state.password.value.fold(
    //   (f) => f.maybeMap(
    //     empty: (_) => 'This is a required field.',
    //     passwordDoNotMatch: (_) => 'Password do not match.',
    //     orElse: () {},
    //   ),
    //   (r) => null,
    // );
  }
}
