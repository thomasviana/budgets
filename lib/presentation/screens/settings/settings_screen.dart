import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/auth/auth_bloc.dart';
import '../../core/settings/settings_bloc.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';

class SettingsScreen extends StatelessWidget {
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
              largeTitle: Text(AppLocalizations.of(context)!.misc_settings),
            ),
            SliverToBoxAdapter(
              child: SettingsContent(),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.misc_settings,
          ),
        ),
        body: SettingsContent(),
      );
    }
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.misc_profile),
          leading: Icon(Icons.person_outline),
          trailing: Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
          onTap: () {
            AppNavigator.navigateToProfilePage(context);
          },
        ),
        Divider(height: 2),
        ListTile(
          title: Text(AppLocalizations.of(context)!.misc_categories),
          leading: Icon(Icons.folder_open),
          trailing: Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
          onTap: () => AppNavigator.navigateToCategoriesPage(context),
        ),
        Divider(height: 2),
        ListTile(
          title: Text(AppLocalizations.of(context)!.misc_accounts),
          leading: Icon(Icons.account_balance),
          trailing: Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
          onTap: () => AppNavigator.navigateToAccountsPage(context),
        ),
        Divider(height: 2),
        ListTile(
          title: Text(AppLocalizations.of(context)!.misc_budgets),
          leading: Icon(Icons.all_inbox),
          trailing: Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
          onTap: () => AppNavigator.navigateToBudgetsPage(context),
        ),
        Divider(height: 2),
        ListTile(
          title: Text(
            'Reset setttings from factory',
            style: TextStyle(color: AppColors.red),
          ),
          leading: Icon(Icons.restore_outlined, color: AppColors.red),
          onTap: () {
            context.read<SettingsBloc>().add(ResetFromFactoryRequested());
          },
        ),
        Divider(height: 2),
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.misc_logOut,
            style: TextStyle(color: AppColors.red),
          ),
          leading: Icon(Icons.logout, color: AppColors.red),
          onTap: () {
            context.read<AuthBloc>().add(LogoutRequested());
            AppNavigator.navigateToAuthPage(context);
          },
        ),
        Divider(height: 2),
      ],
    );
  }
}
