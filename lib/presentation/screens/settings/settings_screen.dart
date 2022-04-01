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
              trailing: GestureDetector(
                child: Icon(
                  CupertinoIcons.restart,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
                onTap: () => _showResetOption(context, Platform.isIOS),
              ),
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
          actions: [
            IconButton(
              onPressed: () => _showResetOption(context, false),
              icon: Icon(
                Icons.restart_alt,
              ),
            )
          ],
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

Future<void> _showResetOption(
  BuildContext context,
  bool isIOS,
) async {
  if (isIOS)
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Restaurar datos de fabrica'),
            onPressed: () {
              Navigator.pop(context);
              context.read<SettingsBloc>().add(ResetFromFactoryRequested());
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancelar',
            style: TextStyle(color: AppColors.red),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  else
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        title: Text(
          'Restablecer datos de fabrica',
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Los datos guardados serán eliminados y se restablecerán los datos de fábrica.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<SettingsBloc>().add(ResetFromFactoryRequested());
            },
            child: Text(
              'Restablecer',
              style: TextStyle(color: AppColors.red),
            ),
          ),
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
}
