import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/settings/settings_bloc.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';

class AccountsScreen extends StatelessWidget {
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
              largeTitle: Text(AppLocalizations.of(context)!.misc_accounts),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
              trailing: GestureDetector(
                child: const Icon(
                  CupertinoIcons.add,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
                onTap: () => AppNavigator.navigateToEditAccountPage(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Material(child: AccountsContent()),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.misc_accounts),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => AppNavigator.navigateToEditAccountPage(context),
            )
          ],
        ),
        body: AccountsContent(),
      );
    }
  }
}

class AccountsContent extends StatelessWidget {
  const AccountsContent({
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
          itemCount: state.accounts.length,
          separatorBuilder: (BuildContext context, int index) =>
              Platform.isIOS ? const Divider(height: 2) : const SizedBox(),
          itemBuilder: (BuildContext context, int index) {
            NetworkImage? image;
            Icon? accountIcon;
            bool isImageAvailable;
            final account = state.accounts[index];
            state.accounts.sort(
              (a, b) => (a.type.toString()).compareTo(b.type.toString()),
            );
            if ((account.imageUrl ?? '').isNotEmpty) {
              isImageAvailable = true;
              image = NetworkImage(account.imageUrl!);
            } else {
              isImageAvailable = false;
              accountIcon = Icon(
                IconData(
                  account.icon,
                  fontFamily: 'MaterialIcons',
                ),
                color: AppColors.white,
              );
            }
            return ListTile(
              leading: CircleAvatar(
                maxRadius: 20,
                backgroundColor: Color(account.color),
                backgroundImage: image,
                child: isImageAvailable ? null : accountIcon,
              ),
              title: Text(
                account.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing:
                  Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
              onTap: () => AppNavigator.navigateToEditAccountPage(
                context,
                account: account,
              ),
            );
          },
        );
      },
    );
  }
}
