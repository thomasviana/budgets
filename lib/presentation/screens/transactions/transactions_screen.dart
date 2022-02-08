import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/presentation/core/settings/settings_bloc.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'transactions_bloc/transactions_screen_bloc.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionssScreenState createState() => _TransactionssScreenState();
}

class _TransactionssScreenState extends State<TransactionsScreen> {
  late TransactionsScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<TransactionsScreenBloc>()..add(GetUserTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsScreenBloc, TransactionsScreenState>(
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
                      AppNavigator.navigateToEditTransactionPage(context);
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
    Budget _getBudgetAbreviation(TransactionBudgetId? id) {
      final budgets = context.read<SettingsBloc>().state.budgets;
      final budget = budgets.firstWhere(
        (budget) => budget.id.value == id!.value,
      );
      return budget;
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
            transaction: transaction,
            budget: _getBudgetAbreviation(transaction.txBudgetId),
            onPressed: () => AppNavigator.navigateToEditTransactionPage(
              context,
              transaction: transaction,
            ),
            onDeletePressed: (_) =>
                bloc.add(TransactionDeleted(transactionId: transaction.id)),
          );
        },
      );
    }
  }
}
