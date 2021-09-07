import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/widget_card.dart';
import 'package:flutter/material.dart';

import 'components/body_header.dart';
import 'components/last_records.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> homeWidgets = [
    SliverAppBar(
      brightness: Brightness.light,
      backgroundColor: kPrimayColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_on,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ],
    ),
    SliverPersistentHeader(
      delegate: HeaderDelegate(),
    ),
    LastRecordsWidget(),
    WidgetCard(
      title: 'Spending',
      content: Container(
        width: double.infinity,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                  child:
                      Icon(Icons.donut_large, size: 150, color: Colors.orange)),
            ),
            Text(
              'Show more',
              textAlign: TextAlign.end,
              style: TextStyle(color: kAccentColor),
            )
          ],
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: homeWidgets,
      ),
    );
  }
}
