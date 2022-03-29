import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class IncomesByCategory extends StatelessWidget {
  const IncomesByCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Por categoría',
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return PieChartWidget(
            data: state.incomeCategoriesData,
            total: state.incomes,
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
