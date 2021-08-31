import 'package:flutter/material.dart';

Color kTealColor = Colors.tealAccent.shade100;
Color kBlueColor = Colors.lightBlue.shade300;

Widget appBarGradient = Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [kBlueColor, kTealColor],
    ),
  ),
);
