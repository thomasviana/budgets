import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../cubit/auth_screen_cubit.dart';

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
  late FocusNode myFocusNode1;
  late FocusNode myFocusNode2;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
    myFocusNode1 = FocusNode();
    myFocusNode2 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode1.dispose();
    myFocusNode2.dispose();
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
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(myFocusNode1);
            },
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
            focusNode: myFocusNode1,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(myFocusNode2);
            },
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
              focusNode: myFocusNode2,
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
    return null;
  }

  String? passwordValidator(String? value) {
    if (!widget.state.password.value.isNotEmpty) {
      return 'This is a required field.';
    } else if (!widget.state.password.isSecure) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  String? passwordConfirmationValidator(String? value) {
    if (!widget.state.confirmationPassword.value.isNotEmpty) {
      return 'This is a required field.';
    }
    if (widget.state.isCreateAccountMode) {
      if (widget.state.password != widget.state.confirmationPassword) {
        return "Doesn't match the previous one.";
      }
    }
    return null;
  }
}
