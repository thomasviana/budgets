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

class MyHeader {
  final String title;
  final bool visible;

  MyHeader(
    this.title,
    this.visible,
  );
}

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionssScreenState createState() => _TransactionssScreenState();
}

class _TransactionssScreenState extends State<TransactionsScreen> {
  late TransactionsScreenBloc bloc;

  final headerNotifier = ValueNotifier<MyHeader?>(null);

  void _refreshHeader(String title, bool visible, {String? lastOne}) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.title ?? title;
    final headerVisible = headerValue?.visible ?? false;

    if (headerTitle != title || lastOne != null || headerVisible != visible) {
      Future.microtask(() {
        if (!visible && lastOne != null) {
          headerNotifier.value = MyHeader(lastOne, true);
        } else {
          headerNotifier.value = MyHeader(title, visible);
        }
      });
    }
  }

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
        height: 60,
        color: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          DateFormat('MMM d', AppLocalizations.of(context)!.localeName)
              .format(date),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => TransactionListTile(
            transaction: transactions[i],
            budget: _getBudgetAbreviation(transactions[i].txBudgetId),
            onPressed: () => AppNavigator.navigateToEditTransactionPage(
              context,
              transaction: transactions[i],
            ),
            onDeletePressed: (_) =>
                bloc.add(TransactionDeleted(transactionId: transactions[i].id)),
          ),
          childCount: transactions
              .where((transaction) => transaction.date.day == date.day)
              .length,
        ),
      ),
    );
  }
}

const MAX_HEADER_TITLE_HEIGHT = 55.0;
typedef OnHeaderChanged = void Function(bool visible);

class MyHeaderTitle extends SliverPersistentHeaderDelegate {
  final String title;
  final OnHeaderChanged onHeaderChanged;
  MyHeaderTitle(
    this.title,
    this.onHeaderChanged,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset > 0) {
      onHeaderChanged(false);
    } else {
      onHeaderChanged(true);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  double get maxExtent => MAX_HEADER_TITLE_HEIGHT;

  @override
  double get minExtent => MAX_HEADER_TITLE_HEIGHT;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
