import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/categories/application.dart';
import '../../../core/categories/domain.dart';
import '../../../core/user/application.dart';
import '../../../core/user/domain.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  CheckAuthStatus checkAuthStatus;
  GetCategories getCategories;
  SaveCategories saveCategories;
  LogOut logOut;

  AuthCubit(
    this.checkAuthStatus,
    this.getCategories,
    this.saveCategories,
    this.logOut,
  ) : super(AuthState.initial());

  Future<void> onAuthCheckRequested() async {
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
            // categories: categories ?? state.categories,
          ),
        );
      },
    );
  }

  // Future<void> _saveCategoriesOnDb() async {
  //   emit(
  //     state.copyWith(
  //       categories: state.categories
  //           .map((category) => category..setUserId(state.userEntity.id.value))
  //           .toList(),
  //     ),
  //   );
  //   saveCategories(categories: state.categories);
  // }

  Future<void> onLogOut() async {
    await logOut();
    emit(state.copyWith(isUnauthenticated: true));
  }
}
