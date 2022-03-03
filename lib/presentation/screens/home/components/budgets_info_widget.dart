import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/settings/settings_bloc.dart';
import '../../../core/transactions/transactions_bloc.dart';
import '../../../resources/resources.dart';
import '../home_bloc/home_screen_bloc.dart';

class BudgetsInfoWidget extends StatefulWidget {
  const BudgetsInfoWidget({Key? key}) : super(key: key);

  @override
  State<BudgetsInfoWidget> createState() => _BudgetsInfoWidgetState();
}

class _BudgetsInfoWidgetState extends State<BudgetsInfoWidget> {
  late HomeScreenBloc bloc;
  late SettingsBloc settingsBloc;

  @override
  void initState() {
    settingsBloc = context.read<SettingsBloc>();
    bloc = context.read<HomeScreenBloc>()..add(BudgetsInfoRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Presupuestos',
      actionTitle: 'Ver mas',
      // onActionPressed: () {},
      onActionPressed: () {},
      content: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.filteredTransactions.isEmpty) {
            final dateString = DateFormat(
              'MMMM - yyyy',
              AppLocalizations.of(context)!.localeName,
            ).format(state.date);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No hay transacciones en $dateString',
                style: TextStyle(color: AppColors.greyDisabled),
              ),
            );
          } else {
            return BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 8),
                    itemCount: state.budgets.length,
                    itemBuilder: (BuildContext context, int index) {
                      final budget = state.budgets[index];
                      bool hasAbbreviation = true;
                      if (budget.abbreviation == null ||
                          budget.abbreviation!.isEmpty) {
                        hasAbbreviation = false;
                      }
                      final budgetRatio =
                          (state.budgetsInfo[budget]!['spent']! /
                                  state.budgetsInfo[budget]!['budgeted']!) *
                              100.0;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                            currentValue: budgetRatio.isNaN ? 0 : budgetRatio,
                            displayText: '%',
                            backgroundColor:
                                AppColors.greyDisabled.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                            size: 20,
                            changeColorValue: 105,
                            changeProgressColor: AppColors.red.withOpacity(0.6),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
