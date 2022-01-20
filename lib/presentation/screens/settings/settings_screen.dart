import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/auth/auth_cubit.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.greyBackground,
      child: NestedScrollView(
        headerSliverBuilder: (ctx, inner) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text(AppLocalizations.of(context)!.misc_settings),
          )
        ],
        body: Column(
          children: [
            Divider(height: 2),
            ListTile(
              title: Text(AppLocalizations.of(context)!.misc_profile),
              leading: Icon(Icons.person_outline),
              trailing: Icon(Icons.chevron_right),
              autofocus: true,
              enableFeedback: true,
              onTap: () {
                AppNavigator.navigateToProfilePage(context);
              },
            ),
            Divider(height: 2),
            ListTile(
              title: Text(AppLocalizations.of(context)!.misc_categories),
              leading: Icon(Icons.folder_open),
              trailing: Icon(Icons.chevron_right),
              onTap: () => AppNavigator.navigateToCategoriesPage(context),
            ),
            Divider(height: 2),
            ListTile(
              title: Text(AppLocalizations.of(context)!.misc_accounts),
              leading: Icon(Icons.account_balance),
              trailing: Icon(Icons.chevron_right),
              onTap: () => AppNavigator.navigateToAccountsPage(context),
            ),
            Divider(height: 2),
            ListTile(
              title: Text(AppLocalizations.of(context)!.misc_budgets),
              leading: Icon(Icons.all_inbox),
              trailing: Icon(Icons.chevron_right),
              onTap: () => AppNavigator.navigateToBudgetsPage(context),
            ),
            Divider(height: 2),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.misc_logOut,
                style: TextStyle(color: AppColors.red),
              ),
              leading: Icon(Icons.logout, color: AppColors.red),
              onTap: () {
                context.read<AuthCubit>().onLogOut();
                AppNavigator.navigateToAuthPage(context);
              },
            ),
            Divider(height: 2),
          ],
        ),
      ),
    );
  }
}
