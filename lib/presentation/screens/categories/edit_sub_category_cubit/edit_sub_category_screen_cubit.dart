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

  Future<void> init(SubCategory subCategory) async {
    emit(state.copyWith(subCategory: subCategory));
  }

  void onNameChanged(String? name) => emit(
        state.copyWith(
          subCategory: state.subCategory!..updateName(name!),
          isSaveButtonEnabled: true,
        ),
      );

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
}
