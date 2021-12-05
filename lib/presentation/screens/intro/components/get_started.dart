import 'package:flutter/material.dart';

import '../../../routes/app_navigator.dart';
import '../../../widgets/rounded_button.dart';

class GetStarted extends StatelessWidget {
  final String text;
  final bool isButtonEnabled;

  const GetStarted({
    Key? key,
    required this.text,
    required this.isButtonEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
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
            label: 'Get Started',
            isEnabled: isButtonEnabled,
            onPressed: () {
              AppNavigator.navigateToAuthPage(context);
            },
          ),
          SizedBox(height: 60),
          Text(text)
        ],
      ),
    );
  }
}
