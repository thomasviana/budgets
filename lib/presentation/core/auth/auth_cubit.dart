import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/account/application.dart';
import '../../../core/account/domain.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  CheckAuthStatus checkAuthStatus;
  LogOut logOut;

  AuthCubit(
    this.checkAuthStatus,
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
