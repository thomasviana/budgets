import 'package:budgets/presentation/widgets/rounded_button.dart';
import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class AuthScreen extends StatelessWidget {
  static Widget create(BuildContext context) => AuthScreen();

  @override
  Widget build(BuildContext context) {
    final isSigningIn = context.watch<AuthCubit>().state is AuthSigningIn;

    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding + 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.donut_large,
              size: 150,
              color: kAccentColor,
            ),
            SizedBox(height: 50),
            Text(
              'Login',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 50),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    autocorrect: true,
                    autofocus: true,
                    controller: emailController,
                    cursorColor: kAccentColor,
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                    ),
                  ),
                  TextFormField(
                    autocorrect: true,
                    autofocus: true,
                    controller: emailController,
                    cursorColor: kAccentColor,
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            RoundedButton(onPressed: () {}, label: "Login"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: 100,
                  color: Colors.grey.shade300,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 40,
                  child: Text(
                    'or',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ),
                Container(
                  height: 1,
                  width: 100,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginButton(
                  imagePath: 'assets/images/google_icon.png',
                  onTap: () {
                    context.read<AuthCubit>().signInWithGoogle();
                  },
                ),
                SizedBox(
                  width: 22,
                ),
                LoginButton(
                  imagePath: 'assets/images/facebook_icon.png',
                  onTap: () {},
                ),
                SizedBox(
                  width: 22,
                ),
                LoginButton(
                  imagePath: 'assets/images/anonymous_icon.png',
                  onTap: () {
                    context.read<AuthCubit>().signInAnonymously();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {},
              child: isSigningIn
                  ? CircularProgressIndicator()
                  : Text('Create account'),
            ),
          ],
        ),
      ),
    ));
  }
}

class LoginButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const LoginButton({
    Key? key,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

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
