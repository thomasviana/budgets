part of 'categories_screen_cubit.dart';

class CategoriesScreenState {
  final bool isLoading;
  List<Category> categories;

  CategoriesScreenState({
    required this.isLoading,
    required this.categories,
  });

  factory CategoriesScreenState.initial() => CategoriesScreenState(
        isLoading: false,
        categories: Category.defaultCategories,
      );

  CategoriesScreenState copyWith({
    bool? isLoading,
    List<Category>? categories,
  }) {
    return CategoriesScreenState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
    );
  }
}
