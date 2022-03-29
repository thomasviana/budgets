import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/stats/stats_bloc.dart';
import '../../resources/resources.dart';
import 'components/expenses_by_account.dart';
import 'components/expenses_by_budget.dart';
import 'components/expenses_by_category.dart';

class ExpensesScreen extends StatelessWidget {
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
                  largeTitle: Text('Egresos'),
                  previousPageTitle: AppLocalizations.of(context)!.misc_back,
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
              ExpensesByBudget(),
              ExpensesByCategory(),
              ExpensesByAccount(),
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
