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
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsScreenCubit, SettingsScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, SettingsScreenState state) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.backgroundColor,
      child: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Settings'),
          ),
        ],
        body: Column(
          children: [
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.arrow_forward_ios),
              autofocus: true,
              enableFeedback: true,
              onTap: () {
                cubit.getProfileInfo();
                AppNavigator.navigateToProfilePage(context);
              },
            ),
            Divider(),
            ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.folder),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => AppNavigator.navigateToProfilePage(context)),
            Divider(),
            ListTile(
                title: Text('Accounts'),
                leading: Icon(Icons.comment_bank),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => AppNavigator.navigateToProfilePage(context)),
            Divider(),
            SizedBox(
              height: 60,
            ),
            Divider(),
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
            Divider(),
          ],
        ),
      ),
    );
  }
}
