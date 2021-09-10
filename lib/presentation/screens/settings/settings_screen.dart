import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings-screen';
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Seetings'),
          ),
        ],
        body: Container(
          child: TextButton.icon(
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
              icon: Icon(Icons.logout),
              label: Text('Logout')),
        ),
      ),
    );
  }
}
