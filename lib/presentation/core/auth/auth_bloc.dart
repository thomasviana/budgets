import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:budgets/core/user/application.dart';
import 'package:budgets/core/user/domain.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  CheckAuthStatus checkAuthStatus;
  LogOut logOut;
  AuthBloc(
    this.checkAuthStatus,
    this.logOut,
  ) : super(AuthState.initial()) {
    on<AuthCheckRequested>((event, emit) async {
      final userOption = await checkAuthStatus();
      userOption.fold(
        () => emit(
          state.copyWith(
            isUnauthenticated: true,
          ),
        ),
        (user) async {
          emit(
            state.copyWith(
              isAuthenticated: true,
              userEntity: user,
            ),
          );
        },
      );
      developer.log('checkAuthStatus');
    });
    on<AuthLogOut>((event, emit) async {
      await logOut();
      emit(state.copyWith(isUnauthenticated: true));
    });
  }
}
