import 'package:budgets/common/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class BudgetsProgress extends StatefulWidget {
  const BudgetsProgress({
    Key? key,
  }) : super(key: key);

  @override
  State<BudgetsProgress> createState() => _BudgetsProgressState();
}

class _BudgetsProgressState extends State<BudgetsProgress> {
  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Progreso',
      content: Column(
        children: [
          Observer<StatsBloc, StatsState>(
            onSuccess: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PRESUPUESTO',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'GASTADO / PRESUPUESTADO',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 8),
                    itemCount: state.budgetsData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final budgetData = state.budgetsData[index];
                      bool hasAbbreviation = true;
                      if (budgetData.abbreviation == null ||
                          budgetData.abbreviation!.isEmpty) {
                        hasAbbreviation = false;
                      }

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
                                      ? budgetData.abbreviation!
                                      : budgetData.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${budgetData.spent.toCurrencyFormat()} / ${budgetData.budgeted.toCurrencyFormat()}',
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          AnimatedProgressBar(
                            currentValue: budgetData.percent,
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
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total presupuestado'),
                      Text(state.incomes.toCurrencyFormat()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total gastado'),
                      Text(state.expenses.toCurrencyFormat()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total ahorros',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        state.balance.toCurrencyFormat(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
            onFailure: (context, state) {
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
            },
          ),
        ],
      ),
    );
  }
}
