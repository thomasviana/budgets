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
          .map(
            (date) => _StickyHeaderList(
              date: date,
              transactions: state.transactions,
              onDelete: (id) => bloc.add(TransactionDeleted(transactionId: id)),
            ),
          )
          .toList();
    }

    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Transactions',
                style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
              ),
              elevation: 0.5,
              floating: true,
              pinned: true,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: AppColors.primaryColor,
                    size: 34,
                  ),
                  onPressed: () =>
                      AppNavigator.navigateToEditTransactionPage(context),
                ),
              ],
              expandedHeight: kToolbarHeight + 45,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final containerHeight =
                      (constraints.biggest.height - 65) / 45;
                  final scaleAnimation =
                      containerHeight < 0.0 ? 0.0 : containerHeight;
                  return Padding(
                    padding: const EdgeInsets.only(top: kToolbarHeight),
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: 24 * scaleAnimation,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            icon: Icon(
                              Icons.chevron_left,
                              color: AppColors.greyPrimary
                                  .withOpacity(scaleAnimation),
                            ),
                            onPressed: () => bloc.add(MonthDecremented()),
                          ),
                          Text(
                            DateFormat('MMMM - yyyy',
                                    AppLocalizations.of(context)!.localeName)
                                .format(state.date),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            iconSize: 24 * scaleAnimation,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            icon: Icon(
                              Icons.chevron_right,
                              color: AppColors.greyPrimary
                                  .withOpacity(scaleAnimation),
                            ),
                            onPressed: () => bloc.add(MonthIncremented()),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (state.transactions.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 3,
                    ),
                    child: Text(
                      'No hay transacciones\ningresadas aún.',
                      style: TextStyle(
                        color: AppColors.greyDisabled,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ..._sliverListContentList(),
          ],
        ),
      );
    }
  }
}

class _StickyHeaderList extends StatelessWidget {
  final DateTime date;
  final List<Transaction> transactions;
  final dynamic Function(TransactionId) onDelete;

  const _StickyHeaderList({
    Key? key,
    required this.date,
    required this.transactions,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Budget _getBudget(TransactionBudgetId? id) {
      final budgets = context.read<SettingsBloc>().state.budgets;
      final budget = budgets.firstWhere(
        (budget) => budget.id.value == id!.value,
      );
      return budget;
    }

    if (transactions.isEmpty) {
      return Center(child: Text('Wmpty'));
    } else {
      return SliverStickyHeader(
        key: UniqueKey(),
        header: Material(
          elevation: 6,
          child: Container(
            height: 30,
            color: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat('MMM d', AppLocalizations.of(context)!.localeName)
                  .format(date),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
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
                budget: _getBudget(transaction.txBudgetId),
                onPressed: () => AppNavigator.navigateToEditTransactionPage(
                  context,
                  transaction: transaction,
                ),
                onDeletePressed: (_) => onDelete(transaction.id),
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
}
