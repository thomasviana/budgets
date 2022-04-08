import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
            AppLocalizations.of(context)!.misc_or,
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ),
        Container(
          height: 1,
          width: 100,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
