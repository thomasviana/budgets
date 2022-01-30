import 'package:bloc/bloc.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

part 'edit_category_screen_event.dart';
part 'edit_category_screen_state.dart';

@injectable
class EditCategoryScreenBloc
    extends Bloc<EditCategoryScreenEvent, EditCategoryScreenState> {
  UpdateCategory updateCategory;
  DeleteCategory deleteCategory;
  GetProfileInfo getProfileInfo;
  GetSubCategories getSubCategories;
  SaveSubCategories saveSubCategories;
  CreateSubCategory createSubCategory;
  CreateCategory createCategory;
  EditCategoryScreenBloc(
    this.updateCategory,
    this.deleteCategory,
    this.getProfileInfo,
    this.getSubCategories,
    this.saveSubCategories,
    this.createSubCategory,
    this.createCategory,
  ) : super(EditCategoryScreenState.initial()) {
    on<CheckCategory>((event, emit) {
      event.category != null
          ? emit(state.copyWith(category: event.category, isEditMode: true))
          : emit(state.copyWith(category: Category.empty(), isEditMode: false));
    });

    on<GetUserSubcategories>((event, emit) {
      getSubCategories(state.category!.id).then(
        (optionSubCategories) => optionSubCategories.fold(
          () => state.isDefaultExpenseCategory
              ? _setDefaultSubCategories(emit)
              : emit(state.copyWith(subCategories: [])),
          (subCategories) => emit(state.copyWith(subCategories: subCategories)),
        ),
      );
    });
    on<CategoryDeleted>(
      (event, emit) async => deleteCategory(state.category!.id),
    );
    on<CategorySaved>(
      (event, emit) async => getProfileInfo().then(
        (userOption) => userOption.fold(
          () {},
          (user) async {
            if (!state.isEditMode) {
              await createCategory(
                categoryUserId: CategoryUserId(user.id.value),
                name: state.category!.name,
                color: state.category!.color,
                icon: state.category!.icon,
                type: state.category!.type,
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
      ),
    );
    on<ColorUpdated>(
      (event, emit) => emit(
        state.copyWith(
          category: state.category!..updateColor(event.color),
        ),
      ),
    );
    on<IconUpdated>(
      (event, emit) => emit(
        state.copyWith(
          category: state.category!..updateIcon(event.icon),
        ),
      ),
    );
    on<NameChanged>(
      (event, emit) => emit(
        state.copyWith(
          category: state.category!..updateName(event.name),
        ),
      ),
    );
    on<TypeChanged>(
      (event, emit) => emit(
        state.copyWith(
          category: state.category!..changeType(event.categoryType),
        ),
      ),
    );
    on<SubcategoryAdded>(
      (event, emit) async => createSubCategory(
        name: 'Nueva subcategoria',
        icon: state.category!.icon,
        color: state.category!.color,
        categoryId: state.category!.id,
      ),
    );
  }

  Future<void> _setDefaultSubCategories(Emitter emit) async {
    final subCategories = SubCategory.allSubCategories;
    await saveSubCategories(subCategories: subCategories);
    emit(state.copyWith(subCategories: subCategories));
  }
}
