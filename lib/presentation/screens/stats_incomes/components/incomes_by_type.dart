import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class IncomesByType extends StatelessWidget {
  const IncomesByType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Por tipo',
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'IA',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
                title: Text('Ingresos Activos'),
                trailing: Text('\$${currency.format(state.activeIncomes)}'),
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'IP',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
                title: Text('Ingresos Pasivos'),
                trailing: Text('\$${currency.format(state.pasiveIncomes)}'),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${currency.format(state.incomes)}',
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
