import 'package:budgets/common/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class BudgetsSavings extends StatelessWidget {
  const BudgetsSavings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Ahorros',
      content: Observer<StatsBloc, StatsState>(
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
                    'AHORROS',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.budgetsDataSortedBySavings.length,
                itemBuilder: (context, index) {
                  final budget = state.budgetsDataSortedBySavings[index];
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(budget.color),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        budget.abbreviation ?? '---',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    title: Text(budget.name),
                    trailing: Text(budget.savings.toCurrencyFormat()),
                  );
                },
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total ahorros',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    state.balance.toCurrencyFormat(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
    );
  }
}
