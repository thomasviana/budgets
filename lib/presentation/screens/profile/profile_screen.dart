import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      child: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          CupertinoSliverNavigationBar(
            stretch: true,
            largeTitle: Text(AppLocalizations.of(context)!.misc_profile),
            previousPageTitle: AppLocalizations.of(context)!.misc_back,
          ),
          _buildBody(context, state),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProfileScreenState state) {
    if (state.isLoading) {
      return SliverToBoxAdapter(child: SizedBox());
    } else {
      return SliverToBoxAdapter(
        child: UserProfile(
          user: state.userEntity,
          isSavingForm: state.isSavingForm,
          isSaveButtonEnabled: state.isSaveButtonEnabled,
        ),
      );
    }
  }
}
