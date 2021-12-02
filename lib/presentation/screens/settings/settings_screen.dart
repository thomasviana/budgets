import 'package:budgets/presentation/core/auth/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/constants.dart';
import '../../routes/app_navigator.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: kBackgroundColor,
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
                onTap: () => AppNavigator.navigateToProfilePage(context)),
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
