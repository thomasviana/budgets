import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/stats/stats_bloc.dart';
import '../../resources/resources.dart';
import 'components/incomes_by_category.dart';
import 'components/incomes_by_type.dart';

class IncomesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              if (Platform.isIOS)
                CupertinoSliverNavigationBar(
                  stretch: true,
                  largeTitle: Text('Ingresos'),
                ),
              if (Platform.isAndroid)
                SliverAppBar(
                  title: Text(
                    'Ingresos',
                  ),
                  elevation: 0.5,
                  floating: true,
                  pinned: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.sort),
                      onPressed: () {},
                    ),
                  ],
                ),
              SliverPersistentHeader(
                pinned: true,
                delegate: DateFilterDelegate(),
              ),
              IncomesByType(),
              IncomesByCategroy(),
              SliverToBoxAdapter(
                child: SizedBox(height: 16),
              )
            ],
          );
        },
      ),
    );
  }
}
