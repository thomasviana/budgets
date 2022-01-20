import 'package:budgets/presentation/core/settings/settings_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';

class BudgetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, SettingsState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Presupuestos'),
              previousPageTitle: 'Atras',
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
                        (_) => context.read<SettingsCubit>().getSettings(),
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

  Widget _buildBody(BuildContext context, SettingsState state) {
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
            Icons.chevron_right,
          ),
          onTap: () => AppNavigator.navigateToEditBudgetPage(
            context,
            (_) => context.read<SettingsCubit>().getSettings(),
            budget: budget,
          ),
        );
      },
    );
  }
}
