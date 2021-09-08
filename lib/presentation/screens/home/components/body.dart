import 'package:flutter/material.dart';
import 'body_header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          BodyHeader(size: size),
          ListView(
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
