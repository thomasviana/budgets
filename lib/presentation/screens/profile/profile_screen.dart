import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/resources.dart';
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
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: Text(AppLocalizations.of(context)!.misc_profile),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
            ),
            SliverToBoxAdapter(
              child: Material(
                child: UserProfile(
                  isSavingForm: state.isSavingForm,
                  isSaveButtonEnabled: state.isSaveButtonEnabled,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.misc_settings,
          ),
        ),
        body: UserProfile(
          isSavingForm: state.isSavingForm,
          isSaveButtonEnabled: state.isSaveButtonEnabled,
        ),
      );
    }
  }
}
