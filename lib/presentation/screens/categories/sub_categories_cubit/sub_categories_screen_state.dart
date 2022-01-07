part of 'sub_categories_screen_cubit.dart';

class SubCategoriesScreenState {
  final bool isLoading;
  List<SubCategory> subCategories;

  SubCategoriesScreenState({
    required this.isLoading,
    required this.subCategories,
  });

  factory SubCategoriesScreenState.initial() => SubCategoriesScreenState(
        isLoading: false,
        subCategories: [],
      );

  SubCategoriesScreenState copyWith({
    bool? isLoading,
    List<SubCategory>? subCategories,
  }) {
    return SubCategoriesScreenState(
      isLoading: isLoading ?? this.isLoading,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}
