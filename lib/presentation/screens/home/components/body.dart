import 'package:flutter/material.dart';
import 'header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Header(),
          ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // WidgetCard(),
              // WidgetCard(),
            ],
          ),
        ],
      ),
    );
  }
}
