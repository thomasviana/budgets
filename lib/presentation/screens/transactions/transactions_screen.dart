import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/presentation/core/settings/settings_bloc.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';

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
    return DefaultStickyHeaderController(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: _buildBody(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, TransactionsScreenState state) {
    List<_StickyHeaderList> _sliverListContentList() {
      final dates = state.dates
          .map((date) => DateTime(date.year, date.month, date.day))
          .toList()
          .toSet()
          .toList();

      return dates
          .map((date) => _StickyHeaderList(
                date: date,
                transactions: state.transactions,
                bloc: bloc,
                state: state,
              ))
          .toList();
    }

    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Transacciones'),
            trailing: IconButton(
              icon: Icon(
                Icons.add_circle,
                color: AppColors.primaryColor,
                size: 34,
              ),
              onPressed: () {
                AppNavigator.navigateToEditTransactionPage(context);
              },
            ),
          ),
          ..._sliverListContentList(),
        ],
      );
    }
  }
}

class _StickyHeaderList extends StatelessWidget {
  const _StickyHeaderList({
    Key? key,
    required this.date,
    required this.transactions,
    required this.bloc,
    required this.state,
  }) : super(key: key);

  final DateTime date;
  final List<Transaction> transactions;
  final TransactionsScreenBloc bloc;
  final TransactionsScreenState state;

  @override
  Widget build(BuildContext context) {
    Budget _getBudgetAbreviation(TransactionBudgetId? id) {
      final budgets = context.read<SettingsBloc>().state.budgets;
      final budget = budgets.firstWhere(
        (budget) => budget.id.value == id!.value,
      );
      return budget;
    }

    return SliverStickyHeader(
      header: Container(
        height: 30,
        color: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          DateFormat('MMM d', AppLocalizations.of(context)!.localeName)
              .format(date),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            final transaction = transactions
                .where((transaction) => transaction.date.day == date.day)
                .toList()[i];
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
          childCount: transactions
              .where((transaction) => transaction.date.day == date.day)
              .length,
        ),
      ),
    );
  }
}
