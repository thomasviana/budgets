import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/presentation/core/settings/settings_cubit.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import 'transactions_cubit/transactions_screen_cubit.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionssScreenState createState() => _TransactionssScreenState();
}

class _TransactionssScreenState extends State<TransactionsScreen> {
  late TransactionsScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TransactionsScreenCubit>()..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsScreenCubit, TransactionsScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, TransactionsScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Transacciones'),
              middle: Text('Transacciones'),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: AppColors.primaryColor,
                      size: 34,
                    ),
                    onPressed: () {
                      AppNavigator.navigateToEditTransactionPage(
                        context,
                        (_) {},
                      );
                    },
                  ),
                ],
              ),
            )
          ],
          body: _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, TransactionsScreenState state) {
    String _getBudgetAbreviation(TransactionBudgetId? id) {
      final budgets = context.read<SettingsCubit>().state.budgets;
      final budget1 = budgets.firstWhere(
        (budget) => budget.id.value == id!.value,
      );
      return budget1.abbreviation!;
    }

    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.separated(
        padding: EdgeInsets.only(top: 8),
        itemCount: state.transactions.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 2),
        itemBuilder: (BuildContext context, int index) {
          final transaction = state.transactions[index];

          return TransactionListTile(
            note: transaction.note,
            budget: _getBudgetAbreviation(transaction.txBudgetId),
            amount: transaction.amount.toString(),
            date: transaction.date.toString(),
            txType: transaction.transactionType,
          );
        },
      );
    }
  }
}
