import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../widgets/rounded_button.dart';

class GetStarted extends StatelessWidget {
  final String text;

  const GetStarted({required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     // ignore: prefer_const_literals_to_create_immutables
      //     colors: [
      //       kPrimayColor,
      //       kAccentColor,
      //     ],
      //   ),
      // ),
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 250,
            height: 250,
          ),
          SizedBox(height: 50),
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 30),
          RoundedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.auth);
            },
            label: 'Get Started',
          ),
          SizedBox(height: 60),
          Text(text)
        ],
      ),
    );
  }
}
