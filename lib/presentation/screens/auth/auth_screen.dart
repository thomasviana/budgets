import 'package:budgets/presentation/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            RoundedButton(onPressed: () {}, label: "Login")
          ],
        ),
      ),
    ));
  }
}
