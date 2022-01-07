import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class CategoriesLocalDataSource {
  Future<void> cacheCategory(Category category);
  Future<void> cacheCategories(List<Category> categories);
  Future<Option<List<Category>>> getCachedCategories(CategoryUserId userId);
  Future<void> deleteCategory(CategoryId categoryId);

  Future<void> cacheSubCategory(SubCategory subCategory);
  Future<void> cacheSubCategories(List<SubCategory> subCategories);
  Future<Option<List<SubCategory>>> getCachedSubCategories(
      CategoryId categoryId);
  Future<void> deleteSubCategory(CategoryId subCategoryId);
}

@LazySingleton(as: CategoriesLocalDataSource)
class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  final CategoryDao _categoryDao;
  final SubCategoryDao _subCategoryDao;
  final CategoryMapper _categoryMapper;
  final SubCategoryMapper _subCategoryMapper;

  CategoriesLocalDataSourceImpl(
    this._categoryDao,
    this._subCategoryDao,
    this._categoryMapper,
    this._subCategoryMapper,
  );

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
    CategoryUserId userId,
  ) async {
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

  @override
  Future<void> cacheSubCategory(SubCategory subCategory) {
    return Future.value(_subCategoryMapper.toDbDto(subCategory))
        .then((campanion) => _subCategoryDao.createOrUpdate(campanion));
  }

  @override
  Future<void> cacheSubCategories(List<SubCategory> subCategories) {
    return Future.value(_subCategoryMapper.toDbDtoList(subCategories)).then(
      (campanions) => {
        for (var campanion in campanions)
          {_subCategoryDao.createOrUpdate(campanion)}
      },
    );
  }

  @override
  Future<void> deleteSubCategory(CategoryId subCategoryId) {
    return _subCategoryDao.deleteCategory(subCategoryId.value);
  }

  @override
  Future<Option<List<SubCategory>>> getCachedSubCategories(
      CategoryId categoryId) async {
    final subCategories = await _subCategoryDao
        .getSubCategories(categoryId.value)
        .map((dtos) => _subCategoryMapper.fromDbDtoList(dtos))
        .first;
    if (subCategories.isNotEmpty) {
      return some(subCategories);
    } else {
      return none();
    }
  }
}
