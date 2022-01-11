import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'budgets_cubit/transactions_screen_cubit.dart';

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
              largeTitle: Text('Presupuestos'),
              previousPageTitle: 'Ajustes',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      AppNavigator.navigateToEditTransactionPage(
                        context,
                        (_) => cubit.getUserTransactions(),
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
            itemCount: state.budgets.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 2),
            itemBuilder: (BuildContext context, int index) {
              final budget = state.budgets[index];
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
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () => AppNavigator.navigateToEditTransactionPage(
                  context,
                  (_) => cubit.getUserTransactions(),
                  budget: budget,
                ),
              );
            },
          );
        },
      );
    }
  }
}
