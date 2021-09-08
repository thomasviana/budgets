import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/rounded_button.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimayColor, kAccentColor],
          ),
        ),
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.donut_large,
              size: 200,
              color: Colors.white,
            ),
            SizedBox(height: 50),
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 30),
            RoundedButton(
              onPressed: () {},
              label: 'Get Started',
            )
          ],
        ),
      ),
    );
  }
}
