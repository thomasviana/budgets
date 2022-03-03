import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_transaction_bloc/edit_transaction_screen_bloc.dart';

class SelectBudgetScreen extends StatelessWidget {
  final List<Budget> budgets;
  const SelectBudgetScreen({
    Key? key,
    required this.budgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presupuesto'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => AppNavigator.navigateBack(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text('Editar'),
              onPressed: () => AppNavigator.navigateToBudgetsPage(context),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 8,
            ),
            child: Text(
              'PRESUPUESTOS',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: budgets.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              final budget = budgets[index];
              bool hasAbbreviation = true;
              if (budget.abbreviation == null || budget.abbreviation!.isEmpty) {
                hasAbbreviation = false;
              }
              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Color(budget.color),
                  child: hasAbbreviation
                      ? Text(
                          budget.abbreviation!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        )
                      : Icon(
                          Icons.inbox,
                          color: AppColors.white,
                        ),
                ),
                title: Text(
                  budget.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: state.budget.fold(
                  () => null,
                  (stateBudget) {
                    if (stateBudget.id == budget.id) {
                      return Icon(Icons.check, color: AppColors.primaryColor);
                    }
                    return null;
                  },
                ),
                onTap: () {
                  context
                      .read<EditTransactionScreenBloc>()
                      .add(BudgetSelected(budget: budget));
                  Navigator.pop(context);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
