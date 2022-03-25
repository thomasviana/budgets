import 'package:flutter/material.dart';

import 'components/budgets_info_widget.dart';
import 'components/home_app_bar.dart';
import 'components/home_header.dart';
import 'components/last_records_widget.dart';
import 'components/spending_chart_widget.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> homeWidgets = [
    LastRecordsWidget(),
    BudgetsInfoWidget(),
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
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          ...homeWidgets,
        ],
      ),
    );
  }
}
