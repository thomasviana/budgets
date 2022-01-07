part of 'edit_category_screen_cubit.dart';

class EditCategoryScreenState {
  final Category? category;
  final List<SubCategory>? subCategories;
  final UserEntity? user;
  final bool isLoading;
  final bool isSaving;
  final bool isEditMode;

  EditCategoryScreenState({
    this.category,
    this.subCategories,
    this.user,
    required this.isLoading,
    required this.isSaving,
    required this.isEditMode,
  });

  factory EditCategoryScreenState.initial() => EditCategoryScreenState(
        isLoading: false,
        isSaving: false,
        isEditMode: true,
      );

  EditCategoryScreenState copyWith({
    Category? category,
    List<SubCategory>? subCategories,
    UserEntity? user,
    bool? isLoading,
    bool? isSaving,
    bool? isEditMode,
  }) {
    return EditCategoryScreenState(
      category: category ?? this.category,
      subCategories: subCategories ?? this.subCategories,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
