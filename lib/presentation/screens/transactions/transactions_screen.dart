import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';

import '../../../core/budgets/domain.dart';
import '../../../core/transactions/domain.dart';
import '../../core/date/date_bloc.dart';
import '../../core/settings/settings_bloc.dart';
import '../../core/transactions/transactions_bloc.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionssScreenState createState() => _TransactionssScreenState();
}

class _TransactionssScreenState extends State<TransactionsScreen> {
  late TransactionsBloc bloc;
  late DateBloc dateBloc;

  @override
  void initState() {
    super.initState();
    dateBloc = context.read<DateBloc>();
    bloc = context.read<TransactionsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, TransactionsState state) {
    return DefaultStickyHeaderController(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: _buildBody(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, TransactionsState state) {
    List<_StickyHeaderList> _sliverListTransactions() {
      final dates = state.filteredDates
          .map((date) => DateTime(date.year, date.month, date.day))
          .toList()
          .toSet()
          .toList();
      return dates
          .map(
            (date) => _StickyHeaderList(
              date: date,
              transactions: state.filteredTransactions,
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
      final dateString = DateFormat(
        'MMMM - yyyy',
        AppLocalizations.of(context)!.localeName,
      ).format(state.date);
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Transactions',
            ),
            elevation: 0.5,
            floating: true,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(Icons.sort),
                onPressed: () {},
              ),
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _DateFilterDelegate(),
          ),
          if (state.filteredTransactions.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 3,
                  ),
                  child: Text(
                    'No hay transacciones\nen $dateString.',
                    style: TextStyle(
                      color: AppColors.greyDisabled,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          if (state.filteredTransactions.isNotEmpty)
            ..._sliverListTransactions(),
        ],
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

    return SliverStickyHeader(
      key: UniqueKey(),
      header: Container(
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

class _DateFilterDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return DateFilter();
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class DateFilter extends StatefulWidget {
  const DateFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  late TransactionsBloc bloc;
  late DateBloc dateBloc;
  @override
  void initState() {
    bloc = context.read<TransactionsBloc>();
    dateBloc = context.read<DateBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        return Stack(
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: AppColors.white.withOpacity(0.4),
                  alignment: Alignment.center,
                  child: Container(
                    height: 30,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryColor.withOpacity(0.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          icon: Icon(
                            Icons.chevron_left,
                            color: AppColors.white.withOpacity(0.5),
                          ),
                          onPressed: () => dateBloc.add(MonthDecremented()),
                        ),
                        BlocListener<DateBloc, DateState>(
                          listenWhen: (previous, current) =>
                              previous.date != current.date,
                          listener: (context, state) {
                            bloc.add(DateUpdated(date: state.date));
                          },
                          child: Text(
                            DateFormat(
                              'MMMM - yyyy',
                              AppLocalizations.of(context)!.localeName,
                            ).format(state.date),
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          icon: Icon(
                            Icons.chevron_right,
                            color: AppColors.white.withOpacity(0.5),
                          ),
                          onPressed: () => dateBloc.add(MonthIncremented()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
