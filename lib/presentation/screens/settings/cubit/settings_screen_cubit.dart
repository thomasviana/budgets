import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

part 'settings_screen_state.dart';

@injectable
class SettingsScreenCubit extends Cubit<SettingsScreenState> {
  CheckAuthStatus checkAuthStatus;
  GetProfileInfo getProfileInfo;

  SettingsScreenCubit(
    this.checkAuthStatus,
    this.getProfileInfo,
  ) : super(SettingsScreenState.initial());

  // TODO: Probably do not needed.
  // Future<void> init() async {
  //   emit(state.copyWith(isLoading: true));
  //   final displayName = await getProfileInfo();
  //   displayName.fold(
  //     () => null,
  //     (user) => emit(
  //       state.copyWith(
  //         userEntity: user,
  //         isLoading: false,
  //       ),
  //     ),
  //   );
  // }

  // TODO: Probably do not needed.
  // Future<void> onProfilePressed() async {
  //   emit(state.copyWith(isLoading: true));
  //   final optionUser = await getProfileInfo();
  //   optionUser.fold(
  //     () => null,
  //     (user) => emit(state.copyWith(
  //       userEntity: user,
  //       isLoading: false,
  //     )),
  //   );
  // }
}
