import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/auth/auth_cubit.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'cubit/settings_screen_cubit.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsScreenCubit cubit;

  @override
  void initState() {
    super.initState();

    cubit = context.read<SettingsScreenCubit>();
    // cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsScreenCubit, SettingsScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, SettingsScreenState state) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.greyBackground,
      child: NestedScrollView(
        headerSliverBuilder: (ctx, inner) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Ajustes'),
          )
        ],
        body: Column(
          children: [
            Divider(height: 2),
            ListTile(
              title: Text('Perfil'),
              leading: Icon(Icons.person_outline),
              trailing: Icon(Icons.arrow_forward_ios),
              autofocus: true,
              enableFeedback: true,
              onTap: () {
                AppNavigator.navigateToProfilePage(context);
              },
            ),
            Divider(height: 2),
            ListTile(
              title: Text('Categorias'),
              leading: Icon(Icons.folder_open),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => AppNavigator.navigateToCategoriesPage(context),
            ),
            Divider(height: 2),
            ListTile(
              title: Text('Cuentas'),
              leading: Icon(Icons.account_balance),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => AppNavigator.navigateToAccountsPage(context),
            ),
            Divider(height: 2),
            ListTile(
              title: Text('Presupuestos'),
              leading: Icon(Icons.all_inbox),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => AppNavigator.navigateToBudgetsPage(context),
            ),
            Divider(height: 2),
            ListTile(
              title: Text(
                'LogOut',
                style: TextStyle(color: Colors.red),
              ),
              leading: Icon(Icons.logout, color: Colors.red),
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
