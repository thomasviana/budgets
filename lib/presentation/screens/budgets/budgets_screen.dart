import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/settings/settings_bloc.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';

class BudgetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: Text(AppLocalizations.of(context)!.misc_budgets),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
              trailing: GestureDetector(
                child: const Icon(
                  CupertinoIcons.add,
                  color: AppColors.primaryColor,
                ),
                onTap: () => AppNavigator.navigateToEditBudgetPage(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Material(child: BudgetsContent()),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.misc_budgets),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => AppNavigator.navigateToEditBudgetPage(context),
            )
          ],
        ),
        body: BudgetsContent(),
      );
    }
  }
}

class BudgetsContent extends StatelessWidget {
  const BudgetsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: state.budgets.length,
          separatorBuilder: (BuildContext context, int index) =>
              Platform.isIOS ? const Divider(height: 2) : SizedBox(),
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
              trailing:
                  Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
              onTap: () => AppNavigator.navigateToEditBudgetPage(
                context,
                budget: budget,
              ),
            );
          },
        );
      },
    );
  }
}
