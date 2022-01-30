import 'package:bloc/bloc.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:injectable/injectable.dart';

part 'edit_sub_category_screen_event.dart';
part 'edit_sub_category_screen_state.dart';

@injectable
class EditSubCategoryScreenBloc
    extends Bloc<EditSubCategoryScreenEvent, EditSubCategoryScreenState> {
  UpdateSubCategory updateSubCategory;
  DeleteSubCategory deleteSubCategory;
  EditSubCategoryScreenBloc(
    this.updateSubCategory,
    this.deleteSubCategory,
  ) : super(EditSubCategoryScreenState.initial()) {
    on<CheckSubCategory>(
      (event, emit) => emit(state.copyWith(subCategory: event.subCategory)),
    );
    on<SubCategoryDeleted>(
      (event, emit) async => deleteSubCategory(state.subCategory!.id),
    );
    on<SubCategorySaved>(
      (event, emit) async => updateSubCategory(
        categoryId: state.subCategory!.categoryId,
        subCategorId: state.subCategory!.id,
        name: state.subCategory!.name,
        color: state.subCategory!.color,
        icon: state.subCategory!.icon,
      ),
    );
    on<ColorUpdated>(
      (event, emit) => emit(
        state.copyWith(
          subCategory: state.subCategory!..updateColor(event.color),
        ),
      ),
    );
    on<IconUpdated>(
      (event, emit) => emit(
        state.copyWith(
          subCategory: state.subCategory!..updateIcon(event.icon),
        ),
      ),
    );
    on<NameChanged>(
      (event, emit) => emit(
        state.copyWith(
          subCategory: state.subCategory!..updateName(event.name),
        ),
      ),
    );
  }
}
