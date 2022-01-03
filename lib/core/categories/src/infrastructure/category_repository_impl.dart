import 'package:budgets/core/categories/src/infrastructure/datasources/local/local_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final LocalDataSource _localDataSource;

  CategoryRepositoryImpl(
    this._localDataSource,
  );

  @override
  Future<void> delete(CategoryId categoryId) {
    return _localDataSource.deleteCategory(categoryId);
  }

  @override
  Stream<List<Category>> fetchCategories(CategoryUserId userId) {
    return _localDataSource.getCachedCategories(userId);
  }

  @override
  Future<void> save(Category category) {
    return _localDataSource.cacheCategory(category);
  }

  @override
  Future<void> saveList(List<Category> categories) {
    return _localDataSource.cacheCategories(categories);
  }
}
