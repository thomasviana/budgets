import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../resources/resources.dart';
import '../../../routes/app_navigator.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({
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
          Text(
            AppLocalizations.of(context)!.onboarding_get_started_ready,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60),
          RoundedButton(
            label: AppLocalizations.of(context)!.onboarding_get_started_cta,
            isEnabled: true,
            onPressed: () {
              AppNavigator.navigateToAuthPage(context);
            },
          ),
        ],
      ),
    );
  }
}
