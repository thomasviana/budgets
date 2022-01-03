part of 'categories_screen_cubit.dart';

class CategoriesScreenState {
  final bool isLoading;
  List<Category> categories;
  UserEntity? userEntity;

  CategoriesScreenState({
    required this.isLoading,
    required this.categories,
    this.userEntity,
  });

  factory CategoriesScreenState.initial() => CategoriesScreenState(
        isLoading: false,
        categories: Category.defaultCategories,
      );

  CategoriesScreenState copyWith({
    bool? isLoading,
    List<Category>? categories,
    UserEntity? userEntity,
  }) {
    return CategoriesScreenState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      userEntity: userEntity ?? this.userEntity,
    );
  }
}
