import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../application/account.dart';
import '../../../application/src/account/check_auth_status.dart';
import '../../../application/src/account/log_out.dart';
import '../../../domain/account.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  CheckAuthStatus checkAuthStatus;
  GetProfileInfo getProfileInfo;
  LogOut logOut;

  AuthCubit(
    this.checkAuthStatus,
    this.getProfileInfo,
    this.logOut,
  ) : super(AuthState.initial());

  Future<void> onAuthCheckRequested() async {
    final userOption = await checkAuthStatus();

    userOption.fold(
      () => emit(state.copyWith(isUnauthenticated: true)),
      (user) => emit(
        state.copyWith(isAuthenticated: true, userEntity: user),
      ),
    );
  }

  Future<void> onLogOut() async {
    await logOut();
    emit(state.copyWith(isUnauthenticated: true));
  }
}
