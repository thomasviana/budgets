import '../../domain.dart';

abstract class CategoryRepository {
  Stream<List<Category>> fetchCategories(
    CategoryUserId? userId,
  );

  Future<void> save(Category category);

  Future<void> delete(CategoryId categoryId);
}
