import 'package:bloc/bloc.dart';
import 'package:budgets/core/account/application.dart';
import 'package:budgets/core/account/src/domain/auth/user_entity.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/categories/domain.dart';

part 'categories_screen_state.dart';

@injectable
class CategoriesScreenCubit extends Cubit<CategoriesScreenState> {
  GetCategories getCategories;
  GetProfileInfo getProfileInfo;
  CreateCategory createCategory;
  SaveCategories saveCategories;

  CategoriesScreenCubit(
    this.getCategories,
    this.getProfileInfo,
    this.createCategory,
    this.saveCategories,
  ) : super(CategoriesScreenState.initial());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final userOption = await getProfileInfo();
    userOption.fold(
      () => null,
      (user) {
        emit(state.copyWith(user: user, isLoading: false));
      },
    );
    getUserCategories();
  }

  Future<void> getUserCategories() async {
    final userCategories =
        await getCategories(CategoryUserId(state.user!.id.value));
    userCategories.fold(
      () => _setDefaultCategories(),
      (categories) => emit(state.copyWith(categories: categories)),
    );
  }

  Future<void> _setDefaultCategories() async {
    final list = Category.defaultCategories;
    for (final cat in list) {
      cat.setUserId(state.user!.id.value);
    }
    await saveCategories(categories: list);
  }

  Future<void> addUserCategory() async {
    await createCategory(
      categoryUserId: CategoryUserId(state.user!.id.value),
      color: 0xFFF44336,
      icon: 0xe318,
      name: 'Testing Category',
    );
  }
}
