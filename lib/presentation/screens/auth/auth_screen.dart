import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/rounded_button.dart';
import 'package:budgets/bloc/cubit/auth_cubit.dart';

import 'components/custom_divider.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isCreateAccountMode = false;

  @override
  Widget build(BuildContext context) {
    final isSigningIn = context.watch<AuthCubit>().state is AuthSigningIn;
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();

    String? emailValidator(String? value) {
      if (value!.isEmpty) {
        return 'This is a required field.';
      }
      if (!value.contains('@')) {
        return 'Enter a valid email';
      }
    }

    String? passwordValidator(String? value) {
      if (value!.isEmpty) {
        return 'This is a required field.';
      }
      if (isCreateAccountMode) {
        if (value.length < 6) {
          return 'Password must be at least 6 characters long.';
        }
        if (_passwordController.text != _confirmPasswordController.text) {
          return 'Password do not match.';
        }
      }
    }

    void trySubmit() {
      if (_formKey.currentState?.validate() == true) {
        if (isCreateAccountMode) {
          context.read<AuthCubit>().createUserWithEmailAndPassword(
              _emailController.text, _passwordController.text);
        } else {
          context.read<AuthCubit>().signInWithEmailAndPassword(
              _emailController.text, _passwordController.text);
        }
      }
    }

    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding + 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is AuthError)
                    Text(state.message.toString(),
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                        )),
                  Icon(
                    Icons.donut_large,
                    size: 150,
                    color: kAccentColor,
                  ),
                  SizedBox(height: 50),
                  Text(
                    isCreateAccountMode ? 'Register' : 'Login',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 50),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          cursorColor: kAccentColor,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                          decoration: InputDecoration(
                            hintText: 'Enter email',
                          ),
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          cursorColor: kAccentColor,
                          keyboardType: TextInputType.emailAddress,
                          validator: passwordValidator,
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                          ),
                        ),
                        if (isCreateAccountMode)
                          TextFormField(
                            obscureText: true,
                            controller: _confirmPasswordController,
                            cursorColor: kAccentColor,
                            keyboardType: TextInputType.emailAddress,
                            validator: passwordValidator,
                            decoration: InputDecoration(
                              hintText: 'Confirm password',
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  RoundedButton(
                      onPressed: trySubmit,
                      label: isCreateAccountMode ? 'Create account' : 'Login'),
                  SizedBox(height: 20),
                  CustomDivider(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginButton(
                          imagePath: 'assets/images/google_icon.png',
                          onTap: () =>
                              context.read<AuthCubit>().signInWithGoogle()),
                      SizedBox(
                        width: 22,
                      ),
                      LoginButton(
                          imagePath: 'assets/images/facebook_icon.png',
                          onTap: () =>
                              context.read<AuthCubit>().signInWithFacebook()),
                      SizedBox(
                        width: 22,
                      ),
                      LoginButton(
                          imagePath: 'assets/images/anonymous_icon.png',
                          onTap: () =>
                              context.read<AuthCubit>().signInAnonymously()),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isCreateAccountMode = !isCreateAccountMode;
                      });
                      context.read<AuthCubit>().reset();
                    },
                    child: isSigningIn
                        ? CircularProgressIndicator()
                        : Text(isCreateAccountMode
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
          backgroundColor: kBackgroundColor,
        ),
      ),
    );
  }
}
