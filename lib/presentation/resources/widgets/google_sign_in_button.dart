import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../colors.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColors.white,
        elevation: 8,
        minimumSize: Size(200, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/google_icon.png'),
            backgroundColor: AppColors.greyBackground,
          ),
          SizedBox(width: 8),
          Text(
            AppLocalizations.of(context)!.widgets_google_sign_in_button,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
