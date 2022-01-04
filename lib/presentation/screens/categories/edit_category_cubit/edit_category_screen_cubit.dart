import 'package:bloc/bloc.dart';
import 'package:budgets/core/account/domain.dart';
import 'package:budgets/core/account/src/application/get_profile_info.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:injectable/injectable.dart';

part 'edit_category_screen_state.dart';

@injectable
class EditCategoryScreenCubit extends Cubit<EditCategoryScreenState> {
  UpdateCategory updateCategory;
  DeleteCategory deleteCategory;
  GetProfileInfo getProfileInfo;

  EditCategoryScreenCubit(
    this.updateCategory,
    this.deleteCategory,
    this.getProfileInfo,
  ) : super(EditCategoryScreenState.initial());

  Future<void> init(Category category) async {
    emit(state.copyWith(isLoading: true, category: category));
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
}
