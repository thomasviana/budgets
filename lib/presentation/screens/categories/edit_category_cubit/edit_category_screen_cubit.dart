import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/account/domain.dart';
import '../../../../core/account/src/application/get_profile_info.dart';
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

  EditCategoryScreenCubit(
    this.updateCategory,
    this.deleteCategory,
    this.getProfileInfo,
    this.getSubCategories,
    this.saveSubCategories,
  ) : super(EditCategoryScreenState.initial());

  Future<void> init(Category category) async {
    emit(state.copyWith(category: category));
    final userOption = await getProfileInfo();
    userOption.fold(
      () => emit(
        state.copyWith(
          user: UserEntity.empty(),
          isLoading: false,
        ),
      ),
      (user) => emit(
        state.copyWith(
          user: user,
          isLoading: false,
        ),
      ),
    );
    getUserSubCategories();
  }

  Future<void> getUserSubCategories() async {
    final userSubCategories = await getSubCategories(state.category!.id);
    userSubCategories.fold(
      () => _setDefaultSubCategories().then((_) => getUserSubCategories()),
      (subCategories) => emit(state.copyWith(subCategories: subCategories)),
    );
  }

  Future<void> _setDefaultSubCategories() async {
    final subCategories = SubCategory.allSubCategories;
    await saveSubCategories(subCategories: subCategories);
  }

  void onNameChanged(String? name) => emit(
        state.copyWith(
          category: state.category!..updateName(name!),
          isSaveButtonEnabled: true,
        ),
      );

  Future<void> onCategoryDeleted() async {
    await deleteCategory(state.category!.id);
  }

  Future<void> onCategorySaved() async {
    await updateCategory(
      userId: CategoryUserId(state.user!.id.value),
      categoryId: state.category!.id,
      name: state.category!.name,
      color: state.category!.color,
      icon: state.category!.icon,
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
}
