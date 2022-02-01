import 'package:budgets/presentation/core/settings/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';

class AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
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
              largeTitle: Text('Cuentas'),
              previousPageTitle: 'Atras',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () =>
                        AppNavigator.navigateToEditAccountPage(context),
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
      itemCount: state.accounts.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 2),
      itemBuilder: (BuildContext context, int index) {
        NetworkImage? image;
        Icon? accountIcon;
        bool isImageAvailable;
        final account = state.accounts[index];
        state.accounts.sort(
          (a, b) => (a.type.toString()).compareTo(b.type.toString()),
        );
        if (account.imageUrl != null) {
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
          trailing: Icon(
            Icons.chevron_right,
          ),
          onTap: () =>
              AppNavigator.navigateToEditAccountPage(context, account: account),
        );
      },
    );
  }
}
