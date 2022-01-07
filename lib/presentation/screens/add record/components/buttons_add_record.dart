import 'package:flutter/material.dart';

class ButtonAddRecord extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPress;

  const ButtonAddRecord({
    required this.color,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          fixedSize: const Size(0, 55),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
