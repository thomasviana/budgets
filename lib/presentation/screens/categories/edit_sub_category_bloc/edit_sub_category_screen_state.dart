part of 'edit_sub_category_screen_bloc.dart';

class EditSubCategoryScreenState {
  final SubCategory? subCategory;
  final bool isLoading;

  EditSubCategoryScreenState({
    this.subCategory,
    required this.isLoading,
  });

  factory EditSubCategoryScreenState.initial() => EditSubCategoryScreenState(
        isLoading: true,
      );

  EditSubCategoryScreenState copyWith({
    SubCategory? subCategory,
    bool? isLoading,
  }) {
    return EditSubCategoryScreenState(
      subCategory: subCategory ?? this.subCategory,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
