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
        getCategories(CategoryUserId(user.id.value)).first.then(
              (categories) => emit(
                state.copyWith(
                  userEntity: user,
                  categories: categories ?? state.categories,
                  isLoading: false,
                ),
              ),
            );
      },
    );
  }

  Future<void> saveCategoriesToDb() async {
    state.categories
        .map((category) => category.setUserId(state.userEntity!.id.value));
    saveCategories(categories: state.categories);
  }

  Future<void> onAddCategory() async {
    await createCategory(
      categoryUserId: CategoryUserId(state.userEntity!.id.value),
      color: 0xFFF44336,
      icon: 0xe318,
      name: 'Other Category',
    );
    listenCategories();
  }

  Stream<List<Category>?> listenCategories() async* {
    await getCategories(CategoryUserId(state.userEntity!.id.value)).first.then(
          (categories) => emit(
            state.copyWith(categories: categories),
          ),
        );
    yield state.categories;
  }
}
