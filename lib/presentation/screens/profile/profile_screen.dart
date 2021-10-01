import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/user_cubit.dart';

import 'components/user_profile.dart';

class ProfileSreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (ctx, inner) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Profile'),
            previousPageTitle: 'Settings',
          )
        ],
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
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
                  ),
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
