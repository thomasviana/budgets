import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class ExpensesByBudget extends StatelessWidget {
  const ExpensesByBudget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Por presupuesto',
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return PieChartWidget(
            data: state.expenseBudgetsData,
            total: state.expenses,
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
