import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class CategoryRepository {
  Stream<Option<List<Category>>> fetchCategories(
    CategoryUserId userId,
  );

  Future<void> save(Category category);

  Future<void> saveList(List<Category> categories);

  Future<void> delete(CategoryId categoryId);

  Future<void> deleteAll();
}
