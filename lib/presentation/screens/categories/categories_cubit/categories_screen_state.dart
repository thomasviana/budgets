part of 'categories_screen_cubit.dart';

class CategoriesScreenState {
  final bool isLoading;
  List<Category> categories;
  UserEntity? user;

  CategoriesScreenState({
    required this.isLoading,
    required this.categories,
    this.user,
  });

  factory CategoriesScreenState.initial() => CategoriesScreenState(
        isLoading: false,
        categories: Category.defaultCategories,
      );

  CategoriesScreenState copyWith({
    bool? isLoading,
    List<Category>? categories,
    UserEntity? user,
  }) {
    return CategoriesScreenState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      user: user ?? this.user,
    );
  }
}
