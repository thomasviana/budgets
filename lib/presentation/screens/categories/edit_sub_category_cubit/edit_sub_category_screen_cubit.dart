import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/categories/application.dart';
import '../../../../core/categories/domain.dart';

part 'edit_sub_category_screen_state.dart';

@injectable
class EditSubCategoryScreenCubit extends Cubit<EditSubCategoryScreenState> {
  UpdateSubCategory updateSubCategory;
  DeleteSubCategory deleteSubCategory;

  EditSubCategoryScreenCubit(
    this.updateSubCategory,
    this.deleteSubCategory,
  ) : super(EditSubCategoryScreenState.initial());

  void init(SubCategory subCategory) {
    emit(state.copyWith(subCategory: subCategory));
  }

  Future<void> onSubCategoryDeleted() async {
    await deleteSubCategory(state.subCategory!.id);
  }

  Future<void> onSubCategorySaved() async {
    await updateSubCategory(
      categoryId: state.subCategory!.categoryId,
      subCategorId: state.subCategory!.id,
      name: state.subCategory!.name,
      color: state.subCategory!.color,
      icon: state.subCategory!.icon,
    );
  }

  Future<void> onColorUpdated(int newColor) async {
    emit(
      state.copyWith(
        subCategory: state.subCategory!..updateColor(newColor),
      ),
    );
  }

  Future<void> onIconUpdated(int newIcon) async {
    emit(
      state.copyWith(
        subCategory: state.subCategory!..updateIcon(newIcon),
      ),
    );
  }

  void onNameChanged(String? name) => emit(
        state.copyWith(
          subCategory: state.subCategory!..updateName(name!),
        ),
      );
}
