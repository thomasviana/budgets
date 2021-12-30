part of 'sub_categories_screen_cubit.dart';

class SubCategoriesScreenState {
  final bool isLoading;
  List<SubCategory> categories;

  SubCategoriesScreenState({
    required this.isLoading,
    required this.categories,
  });

  factory SubCategoriesScreenState.initial() => SubCategoriesScreenState(
        isLoading: false,
        categories: [],
      );

  SubCategoriesScreenState copyWith({
    bool? isLoading,
    List<SubCategory>? categories,
  }) {
    return SubCategoriesScreenState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
    );
  }
}
