import 'package:bloc/bloc.dart';
import 'package:budgets/core/user/application.dart';
import 'package:budgets/core/user/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/categories/application.dart';
import '../../../../core/categories/domain.dart';

part 'edit_category_screen_state.dart';

@injectable
class EditCategoryScreenCubit extends Cubit<EditCategoryScreenState> {
  UpdateCategory updateCategory;
  DeleteCategory deleteCategory;
  GetProfileInfo getProfileInfo;
  GetSubCategories getSubCategories;
  SaveSubCategories saveSubCategories;
  CreateSubCategory createSubCategory;
  CreateCategory createCategory;

  EditCategoryScreenCubit(
    this.updateCategory,
    this.deleteCategory,
    this.getProfileInfo,
    this.getSubCategories,
    this.saveSubCategories,
    this.createSubCategory,
    this.createCategory,
  ) : super(EditCategoryScreenState.initial());

  Future<void> init(Category? category) async {
    if (category != null) {
      emit(state.copyWith(category: category));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(
          state.copyWith(
            user: UserEntity.empty(),
          ),
        ),
        (user) => emit(
          state.copyWith(
            user: user,
          ),
        ),
      );
      getUserSubCategories();
    } else {
      emit(state.copyWith(isEditMode: false, category: Category.empty()));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(
          state.copyWith(
            user: UserEntity.empty(),
            subCategories: [],
          ),
        ),
        (user) => emit(
          state.copyWith(
            user: user,
            subCategories: [],
          ),
        ),
      );
    }
  }

  Future<void> getUserSubCategories() async {
    if (state.category!.id.value == 'housing' ||
        state.category!.id.value == 'food' ||
        state.category!.id.value == 'transportation' ||
        state.category!.id.value == 'healthCare' ||
        state.category!.id.value == 'services' ||
        state.category!.id.value == 'recreation' ||
        state.category!.id.value == 'shopping' ||
        state.category!.id.value == 'financial') {
      final userSubCategories = await getSubCategories(state.category!.id);
      userSubCategories.fold(
        () => _setDefaultSubCategories().then((_) => getUserSubCategories()),
        (subCategories) => emit(state.copyWith(subCategories: subCategories)),
      );
    } else {
      final userSubCategories = await getSubCategories(state.category!.id);
      userSubCategories.fold(
        () => emit(state.copyWith(subCategories: [])),
        (subCategories) => emit(state.copyWith(subCategories: subCategories)),
      );
    }
  }

  Future<void> _setDefaultSubCategories() async {
    final subCategories = SubCategory.allSubCategories;
    await saveSubCategories(subCategories: subCategories);
  }

  void onNameChanged(String? name) {
    if (state.category == null) return;
    emit(
      state.copyWith(
        category: state.category!..updateName(name!),
        isSaveButtonEnabled: true,
      ),
    );
  }

  Future<void> onCategoryDeleted() async {
    await deleteCategory(state.category!.id);
  }

  Future<void> onCategorySaved({bool isNewCategory = false}) async {
    if (isNewCategory) {
      await createCategory(
        categoryUserId: CategoryUserId(state.user!.id.value),
        name: state.category!.name,
        color: state.category!.color,
        icon: state.category!.icon,
        type: CategoryType.expense,
      );
    } else {
      await updateCategory(
        userId: CategoryUserId(state.user!.id.value),
        categoryId: state.category!.id,
        name: state.category!.name,
        color: state.category!.color,
        icon: state.category!.icon,
      );
    }
  }

  Future<void> onColorUpdated(int newColor) async {
    emit(
      state.copyWith(
        category: state.category!..updateColor(newColor),
      ),
    );
  }

  Future<void> onIconUpdated(int newIcon) async {
    emit(
      state.copyWith(
        category: state.category!..updateIcon(newIcon),
      ),
    );
  }

  Future<void> onAddSubCategory() async {
    await createSubCategory(
      name: 'Nueva subcategoria',
      icon: state.category!.icon,
      color: state.category!.color,
      categoryId: state.category!.id,
    );
  }
}
