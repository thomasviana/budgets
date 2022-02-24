import 'package:bloc/bloc.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

part 'edit_category_screen_event.dart';
part 'edit_category_screen_state.dart';

@injectable
class EditCategoryScreenBloc
    extends Bloc<EditCategoryScreenEvent, EditCategoryScreenState> {
  UpdateCategory updateCategory;
  UpdateSubCategory updateSubCategory;
  DeleteCategory deleteCategory;
  GetSubCategories getSubCategories;
  SetDefaultSubCategories setDefaultSubCategories;
  CreateSubCategory createSubCategory;
  CreateCategory createCategory;
  EditCategoryScreenBloc(
    this.updateCategory,
    this.updateSubCategory,
    this.deleteCategory,
    this.getSubCategories,
    this.setDefaultSubCategories,
    this.createSubCategory,
    this.createCategory,
  ) : super(EditCategoryScreenState.initial()) {
    on<CheckCategory>((event, emit) {
      event.category != null
          ? emit(
              state.copyWith(
                category: event.category,
                isEditMode: true,
                isLoading: false,
              ),
            )
          : emit(
              state.copyWith(
                category: Category.empty(),
                isEditMode: false,
                isLoading: false,
              ),
            );
    });

    on<GetUserSubcategories>((event, emit) async {
      await emit.onEach<Option<List<SubCategory>>>(
        getSubCategories(state.category!.id),
        onData: (optionSubCategories) => optionSubCategories.fold(
          () => state.isDefaultCategory
              ? setDefaultSubCategories()
              : emit(state.copyWith(subCategories: [])),
          (subCategories) => emit(state.copyWith(subCategories: subCategories)),
        ),
      );
    });
    on<CategoryDeleted>(
      (event, emit) async => deleteCategory(state.category!.id),
    );
    on<CategorySaved>((event, emit) async {
      if (!state.isEditMode) {
        // TODO: Not avaiable yet.
        await createCategory(
          name: state.category!.name,
          color: state.category!.color,
          icon: state.category!.icon,
          type: state.category!.type,
        );
      } else {
        await updateCategory(
          categoryId: state.category!.id,
          name: state.category!.name,
          color: state.category!.color,
          icon: state.category!.icon,
        );
        await updateSubCategory(
          categoryId: state.category!.id,
          subCategorId: state.category!.id,
          name: '${state.category!.name} (general)',
          color: state.category!.color,
          icon: state.category!.icon,
        );
      }
    });
    on<ColorUpdated>(
      (event, emit) => emit(
        state.copyWith(
          category: state.category!.copyWith(color: event.color),
        ),
      ),
    );
    on<IconUpdated>(
      (event, emit) => emit(
        state.copyWith(
          category: state.category!.copyWith(icon: event.icon),
        ),
      ),
    );
    on<NameChanged>(
      (event, emit) => emit(
        state.copyWith(
          category: state.category!.copyWith(name: event.name),
        ),
      ),
    );
    on<TypeChanged>(
      (event, emit) => emit(
        state.copyWith(
          category: state.category!.copyWith(type: event.categoryType),
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
}
