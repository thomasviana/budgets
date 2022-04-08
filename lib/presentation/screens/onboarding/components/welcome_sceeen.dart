import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
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
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              text:
                  AppLocalizations.of(context)!.onboarding_welcome_title_line_1,
              style: Theme.of(context).textTheme.headline3,
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!
                      .onboarding_welcome_title_line_2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60),
          Text(AppLocalizations.of(context)!.onboarding_welcome_swipe_message),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
