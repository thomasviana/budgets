import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import 'budgets_cubit/butgets_screen_cubit.dart';

class BudgetsScreen extends StatefulWidget {
  @override
  _BudgetssScreenState createState() => _BudgetssScreenState();
}

class _BudgetssScreenState extends State<BudgetsScreen> {
  late BudgetsScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<BudgetsScreenCubit>();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetsScreenCubit, BudgetsScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, BudgetsScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Presupuestos'),
              previousPageTitle: 'Configuración',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      AppNavigator.navigateToEditBudgetPage(
                        context,
                        (_) => cubit.getUserBudgets(),
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

  Widget _buildBody(BuildContext context, BudgetsScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return FutureBuilder(
        future: cubit.getUserBudgets(),
        builder: (context, snapshot) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 8),
            itemCount: state.budgets.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              final budget = state.budgets[index];
              bool hasAbbreviation = true;
              if (budget.abbreviation == null) {
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
                onTap: () => AppNavigator.navigateToEditBudgetPage(
                  context,
                  (_) => cubit.getUserBudgets(),
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
