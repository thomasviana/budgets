import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/constants.dart';
import 'components/stat_card.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Statistics'),
          ),
        ],
        body: Container(
          padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              statCard(
                context,
                title: 'BALANCE',
                amount: 22300,
                graph: Icon(Icons.donut_large, size: 50, color: kAccentColor),
              ),
              statCard(
                context,
                title: 'INCOMES',
                amount: 5000,
                graph: Icon(Icons.donut_large, size: 50, color: kAccentColor),
              ),
              statCard(
                context,
                title: 'SPENDING',
                amount: 270,
                graph: Icon(Icons.donut_large, size: 50, color: kAccentColor),
              ),
              statCard(
                context,
                title: 'CASH FLOW',
                amount: 4730,
                graph: Icon(Icons.donut_large, size: 50, color: kAccentColor),
              ),
              statCard(
                context,
                title: 'ASSETS',
                amount: 100000,
                graph: Icon(Icons.donut_large, size: 50, color: kAccentColor),
              ),
              statCard(
                context,
                title: 'DEBT',
                amount: 50000,
                graph: Icon(Icons.donut_large, size: 50, color: kAccentColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
