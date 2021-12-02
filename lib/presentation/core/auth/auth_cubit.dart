import 'package:bloc/bloc.dart';
import 'package:budgets/application/src/account/check_auth_status.dart';
import 'package:budgets/application/src/account/log_out.dart';
import 'package:injectable/injectable.dart';

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
      (_) => emit(state.copyWith(isAuthenticated: true)),
    );
  }

  Future<void> onLogOut() async {
    await logOut();
    emit(state.copyWith(isUnauthenticated: true));
  }
}
