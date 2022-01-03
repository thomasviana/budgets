import 'package:budgets/core/categories/domain.dart';
import 'package:injectable/injectable.dart';

import 'categories_table.dart';
import 'category_mapper.dart';

abstract class LocalDataSource {
  Future<void> cacheCategory(Category category);
  Future<void> cacheCategories(List<Category> categories);
  Stream<List<Category>> getCachedCategories(CategoryUserId userId);
  Future<void> deleteCategory(CategoryId categoryId);
}

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final CategoryDao _categoryDao;
  final CategoryMapper _categoryMapper;

  LocalDataSourceImpl(this._categoryDao, this._categoryMapper);

  @override
  Future<void> cacheCategory(Category category) {
    return Future.value(_categoryMapper.toDbDto(category))
        .then((dto) => _categoryDao.createOrUpdate(dto));
  }

  @override
  Future<void> cacheCategories(List<Category> categories) {
    return Future.value(_categoryMapper.toDbDtoList(categories)).then(
      (categories) => {
        for (var category in categories) {_categoryDao.createOrUpdate(category)}
      },
    );
  }

  @override
  Future<void> deleteCategory(CategoryId categoryId) {
    return _categoryDao.deleteCategory(categoryId.value);
  }

  @override
  Stream<List<Category>> getCachedCategories(CategoryUserId userId) {
    return _categoryDao
        .getCategories(userId.value)
        .map((dtos) => _categoryMapper.fromDbDtoList(dtos));
  }
}
