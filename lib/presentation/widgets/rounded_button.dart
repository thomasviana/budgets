import 'package:flutter/material.dart';

import '../resources/colors.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final bool isEnabled;

  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: isEnabled ? AppColors.accentColor : AppColors.greyDisabled,
        elevation: 8,
        minimumSize: Size(200, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: isEnabled
          ? () {
              onPressed();
            }
          : null,
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
