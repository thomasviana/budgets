import 'package:bloc/bloc.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/core/categories/src/application/save_categories.dart';
import 'package:injectable/injectable.dart';

import '../../../core/account/application.dart';
import '../../../core/account/domain.dart';

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
            ), (user) async {
      getCategories(CategoryUserId(user.id.value)).first.then(
            (categories) => {
              emit(
                state.copyWith(
                  isAuthenticated: true,
                  userEntity: user,
                  // categories: categories ?? state.categories,
                ),
              ),
            },
          );
    });
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
