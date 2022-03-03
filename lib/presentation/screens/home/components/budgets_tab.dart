import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/settings/settings_bloc.dart';
import '../../../resources/resources.dart';
import '../../../resources/widgets/animated_progress_bar.dart';
import '../home_bloc/home_screen_bloc.dart';

class BudgetsTab extends StatefulWidget {
  const BudgetsTab({Key? key}) : super(key: key);

  @override
  State<BudgetsTab> createState() => _BudgetsTabState();
}

class _BudgetsTabState extends State<BudgetsTab> {
  late HomeScreenBloc bloc;
  late SettingsBloc settingsBloc;

  @override
  void initState() {
    settingsBloc = context.read<SettingsBloc>();
    bloc = context.read<HomeScreenBloc>()
      ..add(BudgetsInfoRequested(budgets: settingsBloc.state.budgets));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Container(
            color: AppColors.greyBackground,
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Container(
            color: AppColors.greyBackground,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 8),
                  itemCount: state.budgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    final budget = state.budgets[index];
                    bool hasAbbreviation = true;
                    if (budget.abbreviation == null ||
                        budget.abbreviation!.isEmpty) {
                      hasAbbreviation = false;
                    }
                    final budgetRatio = (state.budgetsInfo[budget]!['spent']! /
                            state.budgetsInfo[budget]!['budgeted']!) *
                        100.0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                hasAbbreviation
                                    ? budget.abbreviation!
                                    : budget.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${currency.format(state.budgetsInfo[budget]!['spent'])} / \$${currency.format(state.budgetsInfo[budget]!['budgeted'])}',
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        AnimatedProgressBar(
                          currentValue:
                              budgetRatio.isNaN ? 0 : budgetRatio.toInt(),
                          displayText: '%',
                          backgroundColor:
                              AppColors.greyDisabled.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          size: 24,
                          changeColorValue: 105,
                          changeProgressColor: AppColors.red.withOpacity(0.6),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
