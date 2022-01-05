part of 'edit_sub_category_screen_cubit.dart';

class EditSubCategoryScreenState {
  final SubCategory? subCategory;
  final bool isLoading;
  final bool isSaving;
  final bool isSaveButtonEnabled;

  EditSubCategoryScreenState({
    this.subCategory,
    required this.isLoading,
    required this.isSaving,
    required this.isSaveButtonEnabled,
  });

  factory EditSubCategoryScreenState.initial() => EditSubCategoryScreenState(
        isLoading: false,
        isSaving: false,
        isSaveButtonEnabled: false,
      );

  EditSubCategoryScreenState copyWith({
    SubCategory? subCategory,
    bool? isLoading,
    bool? isSaving,
    bool? isSaveButtonEnabled,
  }) {
    return EditSubCategoryScreenState(
      subCategory: subCategory ?? this.subCategory,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isSaveButtonEnabled: isSaveButtonEnabled ?? this.isSaveButtonEnabled,
    );
  }
}
