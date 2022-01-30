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
}
