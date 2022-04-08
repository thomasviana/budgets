import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  final String imagePath;
  final String text;

  const DescriptionPage({
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Image.asset(
            imagePath,
            width: 300,
            height: 300,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
