import 'package:bloc/bloc.dart';
import 'package:budgets/application/src/account/log_out.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_screen_cubit.freezed.dart';
part 'settings_screen_state.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenState> {
  LogOut logOut;

  SettingsScreenCubit(
    this.logOut,
  ) : super(SettingsScreenState.initial());

  Future<void> onSignInWithFacebook() async => logOut.call();
}
