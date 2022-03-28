import 'package:budgets/presentation/utils/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';

class IncomesByCategroy extends StatelessWidget {
  const IncomesByCategroy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Observer<StatsBloc, StatsState>(
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
        ),
      ),
    );
  }
}
