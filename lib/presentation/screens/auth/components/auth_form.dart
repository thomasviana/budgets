import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

class AuthForm extends StatefulWidget {
  final bool enabled;
  final bool errorEnabled;
  final bool isCreateAccountMode;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onConfirmationPasswordChanged;

  const AuthForm({
    Key? key,
    required this.enabled,
    required this.errorEnabled,
    required this.isCreateAccountMode,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onConfirmationPasswordChanged,
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
      // ignore: deprecated_member_use
      autovalidate: widget.errorEnabled,
      child: Column(
        children: [
          TextFormField(
            key: ValueKey('email'),
            cursorColor: AppColors.accentColor,
            keyboardType: TextInputType.emailAddress,
            // validator: emailValidator,
            decoration: InputDecoration(
              hintText: 'Enter email',
              enabled: widget.enabled,
            ),
            onChanged: widget.onEmailChanged,
          ),
          TextFormField(
              key: ValueKey('password'),
              obscureText: !_isPasswordVisible,
              cursorColor: AppColors.accentColor,
              keyboardType: TextInputType.emailAddress,
              // validator: passwordValidator,
              decoration: InputDecoration(
                hintText: 'Enter password',
              ),
              onChanged: widget.onPasswordChanged),
          if (widget.isCreateAccountMode)
            TextFormField(
              key: ValueKey('confirm_password'),
              obscureText: !_isPasswordVisible,
              cursorColor: AppColors.accentColor,
              keyboardType: TextInputType.emailAddress,
              // validator: passwordValidator,
              decoration: InputDecoration(
                hintText: 'Confirm password',
              ),
              onChanged: widget.onConfirmationPasswordChanged,
            ),
        ],
      ),
    );
  }

  // String? emailValidator(String? value) {
  //   return cubit.state.emailAddress.value.fold(
  //     (f) => f.maybeMap(
  //       empty: (_) => 'This is a required field.',
  //       invalidEmail: (_) => 'Enter a valid email.',
  //       orElse: () {},
  //     ),
  //     (r) => null,
  //   );
  // }

  // String? passwordValidator(String? value) {
  //   return cubit.state.password.value.fold(
  //     (f) => f.maybeMap(
  //       empty: (_) => 'This is a required field.',
  //       shortPassword: (_) => 'Password must be at least 6 characters long.',
  //       passwordDoNotMatch: (_) => 'Password do not match.',
  //       orElse: () {},
  //     ),
  //     (r) => null,
  //   );
}
