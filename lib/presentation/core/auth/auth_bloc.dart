import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/user/application.dart';
import '../../../core/user/domain.dart';

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
