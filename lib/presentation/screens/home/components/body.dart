import 'package:flutter/material.dart';

import 'header.dart';

class Body extends StatelessWidget {
  final String displayName;
  const Body({
    Key? key,
    required this.displayName,
  }) : super(key: key);
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
