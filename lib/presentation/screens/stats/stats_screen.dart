import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/resources.dart';
import 'components/stat_card.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            stretch: true,
            largeTitle: Text('Statistics'),
          ),
          statCard(
            context,
            title: 'BALANCE',
            amount: 22300,
            graph: Icon(
              Icons.donut_large,
              size: 50,
              color: AppColors.primaryColor,
            ),
          ),
          statCard(
            context,
            title: 'INCOMES',
            amount: 5000,
            graph: Icon(
              Icons.donut_large,
              size: 50,
              color: AppColors.primaryColor,
            ),
          ),
          statCard(
            context,
            title: 'SPENDING',
            amount: 270,
            graph: Icon(
              Icons.donut_large,
              size: 50,
              color: AppColors.primaryColor,
            ),
          ),
          statCard(
            context,
            title: 'CASH FLOW',
            amount: 4730,
            graph: Icon(
              Icons.donut_large,
              size: 50,
              color: AppColors.primaryColor,
            ),
          ),
          statCard(
            context,
            title: 'ASSETS',
            amount: 100000,
            graph: Icon(
              Icons.donut_large,
              size: 50,
              color: AppColors.primaryColor,
            ),
          ),
          statCard(
            context,
            title: 'DEBT',
            amount: 50000,
            graph: Icon(
              Icons.donut_large,
              size: 50,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
