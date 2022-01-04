import 'package:budgets/core/categories/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'categories_table.dart';
import 'category_mapper.dart';

abstract class LocalDataSource {
  Future<void> cacheCategory(Category category);
  Future<void> cacheCategories(List<Category> categories);
  Future<Option<List<Category>>> getCachedCategories(CategoryUserId userId);
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
        .then((campanion) => _categoryDao.createOrUpdate(campanion));
  }

  @override
  Future<void> cacheCategories(List<Category> categories) {
    return Future.value(_categoryMapper.toDbDtoList(categories)).then(
      (campanions) => {
        for (var campanion in campanions)
          {_categoryDao.createOrUpdate(campanion)}
      },
    );
  }

  @override
  Future<void> deleteCategory(CategoryId categoryId) {
    return _categoryDao.deleteCategory(categoryId.value);
  }

  @override
  Future<Option<List<Category>>> getCachedCategories(
      CategoryUserId userId) async {
    final categories = await _categoryDao
        .getCategories(userId.value)
        .map((dtos) => _categoryMapper.fromDbDtoList(dtos))
        .first;
    if (categories.isNotEmpty) {
      return some(categories);
    } else {
      return none();
    }
  }
}
