import 'package:budgets/presentation/screens/home/components/home_header.dart';
import 'package:flutter/material.dart';

import 'components/home_app_bar.dart';
import 'components/last_records_widget.dart';
import 'components/spending_chart_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> homeWidgets = [
    SliverToBoxAdapter(child: SizedBox(height: 16)),
    LastRecordsWidget(),
    SpendingChart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          HomeAppBar(),
          HomeHeader(),
          ...homeWidgets,
        ],
      ),
    );
  }
}
