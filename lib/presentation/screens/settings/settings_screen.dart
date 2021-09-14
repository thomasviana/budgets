import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budgets/data/repository/implementation/user_repository.dart';
import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:budgets/src/bloc/cubit/user_cubit.dart';

import 'components/user_profile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(UserRepository())..getUser(),
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
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
                    UserProfile(
                      user: state.user,
                      pickedImage: state.pickedImage,
                      isSaving: state.isSaving,
                    ),
                    Container(
                      child: TextButton.icon(
                        onPressed: () {
                          context.read<AuthCubit>().signOut();
                        },
                        icon: Icon(Icons.logout),
                        label: Text('Logout'),
                      ),
                    ),
                  ],
                );
              }
              throw Exception();
            },
          ),
        ),
      ),
    );
  }
}
