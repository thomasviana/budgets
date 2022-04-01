import 'dart:io' show Platform;

import 'package:budgets/presentation/screens/stats_budgets/components/budgets_progress.dart';
import 'package:budgets/presentation/screens/stats_budgets/components/budgets_savings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/stats/stats_bloc.dart';
import '../../resources/resources.dart';

class BudgetsStatsScreen extends StatelessWidget {
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
                  largeTitle: Text('Presupuestos'),
                  previousPageTitle: AppLocalizations.of(context)!.misc_back,
                ),
              if (Platform.isAndroid)
                SliverAppBar(
                  title: Text(
                    'Presupuestos',
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
              BudgetsProgress(),
              BudgetsSavings(),
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
