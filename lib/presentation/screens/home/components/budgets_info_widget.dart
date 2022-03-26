import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class BudgetsInfoWidget extends StatelessWidget {
  const BudgetsInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Presupuestos',
      actionTitle: 'Ver mas',
      onActionPressed: () {},
      content: Column(
        children: [
          Observer<StatsBloc, StatsState>(
            onSuccess: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 8),
                    itemCount: state.budgets.length,
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
                                  '\$${currency.format(budgetData.spent)} / \$${currency.format(budgetData.budgeted)}',
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
