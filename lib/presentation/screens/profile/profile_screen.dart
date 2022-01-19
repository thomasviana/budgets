import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/user_profile.dart';
import 'cubit/profile_screen_cubit.dart';

class ProfileSreen extends StatefulWidget {
  @override
  State<ProfileSreen> createState() => _ProfileSreenState();
}

class _ProfileSreenState extends State<ProfileSreen> {
  late ProfileScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileScreenCubit>();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, ProfileScreenState state) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: NestedScrollView(
        headerSliverBuilder: (ctx, inner) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Perfil'),
            previousPageTitle: 'Ajustes',
          )
        ],
        body: _buildBody(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProfileScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        children: [
          UserProfile(
            user: state.userEntity,
            isSavingForm: state.isSavingForm,
            isSaveButtonEnabled: state.isSaveButtonEnabled,
          ),
        ],
      );
    }
  }
}
