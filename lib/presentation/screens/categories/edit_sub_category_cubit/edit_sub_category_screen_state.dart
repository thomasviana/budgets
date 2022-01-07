part of 'edit_sub_category_screen_cubit.dart';

class EditSubCategoryScreenState {
  final SubCategory? subCategory;
  final bool isLoading;
  final bool isSaving;

  EditSubCategoryScreenState({
    this.subCategory,
    required this.isLoading,
    required this.isSaving,
  });

  factory EditSubCategoryScreenState.initial() => EditSubCategoryScreenState(
        isLoading: false,
        isSaving: false,
      );

  EditSubCategoryScreenState copyWith({
    SubCategory? subCategory,
    bool? isLoading,
    bool? isSaving,
  }) {
    return EditSubCategoryScreenState(
      subCategory: subCategory ?? this.subCategory,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
