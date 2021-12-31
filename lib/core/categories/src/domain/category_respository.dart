import '../../domain.dart';

abstract class CategoryRepository {
  Stream<List<Category>> fetchCategories(
    CategoryUserId? userId,
  );

  Future<void> save(Category note);

  Future<void> delete(CategoryId categoryId);
}
