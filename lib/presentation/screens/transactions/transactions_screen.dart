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
    cubit = context.read<TransactionsScreenCubit>();
    cubit.init();
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
                          context, (_) => cubit.getUserTransactions());
                      // showModalBottomSheet(
                      //   backgroundColor: Colors.transparent,
                      //   isScrollControlled: true,
                      //   context: context,
                      //   builder: (context) => EditTransactionScreen(),
                      // );
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
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return FutureBuilder(
        future: cubit.getUserTransactions(),
        builder: (context, snapshot) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 8),
            itemCount: state.transactions.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 2),
            itemBuilder: (BuildContext context, int index) {
              final transaction = state.transactions[index];

              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(
                    Icons.track_changes_rounded,
                    color: AppColors.white,
                  ),
                ),
                title: Text(
                  transaction.note,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () => AppNavigator.navigateToEditTransactionPage(
                  context,
                  (_) => cubit.getUserTransactions(),
                  transaction: transaction,
                ),
              );
            },
          );
        },
      );
    }
  }
}
