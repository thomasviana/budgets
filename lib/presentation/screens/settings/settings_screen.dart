import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:budgets/src/bloc/cubit/user_cubit.dart';
import 'package:budgets/src/navigation/routes.dart';

import '../../../constants.dart';

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
        body: BlocBuilder<UserCubit, UserState>(
          builder: (_, state) {
            if (state is UserLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserReadyState) {
              return Column(
                children: [
                  ListTile(
                    title: Text('Profile'),
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.arrow_forward_ios),
                    autofocus: true,
                    enableFeedback: true,
                    onTap: () => Navigator.pushNamed(context, Routes.profile),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Categories'),
                    leading: Icon(Icons.folder),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.pushNamed(context, Routes.profile),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Accounts'),
                    leading: Icon(Icons.comment_bank),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.pushNamed(context, Routes.profile),
                  ),
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
                    onTap: () => context.read<AuthCubit>().signOut(),
                  ),
                  Divider(),
                ],
              );
            }
            throw Exception();
          },
        ),
      ),
    );
  }
}
