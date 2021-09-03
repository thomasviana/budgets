import 'package:budgets/constants.dart';
import 'package:budgets/screens/home/components/body_header.dart';
import 'package:budgets/widgets/widget_card.dart';
import 'package:flutter/material.dart';

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
              WidgetCard(),
              WidgetCard(),
              WidgetCard(),
            ],
          ),
        ],
      ),
    );
  }
}
