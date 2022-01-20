import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/categories/application.dart';
import '../../../../core/categories/domain.dart';
import '../../../../core/user/application.dart';

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

  void init(Category? category) {
    emit(state.copyWith(category: category ?? Category.empty()));
  }

  Future<void> getUserSubCategories() async {
    getSubCategories(state.category!.id).then(
      (optionSubCategories) => optionSubCategories.fold(
        () => state.isDefaultCategory
            ? _setDefaultSubCategories()
            : emit(state.copyWith(subCategories: [])),
        (subCategories) => emit(state.copyWith(subCategories: subCategories)),
      ),
    );
  }

  Future<void> _setDefaultSubCategories() async {
    final subCategories = SubCategory.allSubCategories;
    await saveSubCategories(subCategories: subCategories);
    emit(state.copyWith(subCategories: subCategories));
  }

  Future<void> onCategoryDeleted() async {
    await deleteCategory(state.category!.id);
  }

  Future<void> onCategorySaved({bool isNewCategory = false}) async {
    getProfileInfo().then(
      (userOption) => userOption.fold(
        () {},
        (user) async {
          if (isNewCategory) {
            await createCategory(
              categoryUserId: CategoryUserId(user.id.value),
              name: state.category!.name,
              color: state.category!.color,
              icon: state.category!.icon,
              type: CategoryType.expense,
            );
          } else {
            await updateCategory(
              userId: CategoryUserId(user.id.value),
              categoryId: state.category!.id,
              name: state.category!.name,
              color: state.category!.color,
              icon: state.category!.icon,
            );
          }
        },
      ),
    );
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

  void onNameChanged(String? name) {
    emit(
      state.copyWith(
        category: state.category!..updateName(name!),
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
