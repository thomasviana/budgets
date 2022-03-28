import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/stats/stats_bloc.dart';
import '../../resources/resources.dart';
import 'components/stat_card.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              if (Platform.isIOS)
                CupertinoSliverNavigationBar(
                  stretch: true,
                  largeTitle: Text('Stats'),
                ),
              if (Platform.isAndroid)
                SliverAppBar(
                  title: Text(
                    'Stats',
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
              StatsCard(
                title: 'INGRESOS',
                amount: state.incomes,
                trailing: Icon(
                  Icons.donut_large,
                  size: 50,
                  color: AppColors.primaryColor,
                ),
              ),
              StatsCard(
                title: 'EGRESOS',
                amount: state.expenses,
                trailing: Icon(
                  Icons.donut_large,
                  size: 50,
                  color: AppColors.primaryColor,
                ),
              ),
              StatsCard(
                title: 'FLUJO DE EFECTIVO',
                amount: state.balance,
                trailing: Icon(
                  Icons.donut_large,
                  size: 50,
                  color: AppColors.primaryColor,
                ),
              ),
              StatsCard(
                title: 'PRESUPUESTOS',
                amount: state.expenses,
                trailing: Icon(
                  Icons.donut_large,
                  size: 50,
                  color: AppColors.primaryColor,
                ),
              ),
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
