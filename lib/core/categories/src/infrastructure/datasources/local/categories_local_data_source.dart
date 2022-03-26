import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class CategoriesLocalDataSource {
  Future<void> cacheCategory(Category category);
  Future<void> cacheCategories(List<Category> categories);
  Stream<Option<List<Category>>> getCachedCategories(CategoryUserId userId);
  Future<void> deleteCategory(CategoryId categoryId);
  Future<void> deleteAllCategories();
  Future<void> deleteAllSubCategories();

  Future<void> cacheSubCategory(SubCategory subCategory);
  Future<void> cacheSubCategories(List<SubCategory> subCategories);
  Stream<Option<List<SubCategory>>> getAllCachedSubCategories();
  Stream<Option<List<SubCategory>>> getCachedSubCategories(
    CategoryId categoryId,
  );

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
  Future<void> deleteAllCategories() {
    return _categoryDao.deleteAllCategories();
  }

  @override
  Stream<Option<List<Category>>> getCachedCategories(
    CategoryUserId userId,
  ) =>
      _categoryDao.getCategories(userId.value).map(
            (dtos) => dtos.isEmpty
                ? none()
                : some(_categoryMapper.fromDbDtoList(dtos)),
          );

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
  Future<void> deleteAllSubCategories() {
    return _subCategoryDao.deleteAllSubCategories();
  }

  @override
  Stream<Option<List<SubCategory>>> getCachedSubCategories(
    CategoryId categoryId,
  ) {
    return _subCategoryDao.getSubCategories(categoryId.value).map(
          (dtos) => dtos.isEmpty
              ? none()
              : some(_subCategoryMapper.fromDbDtoList(dtos)),
        );
  }

  @override
  Stream<Option<List<SubCategory>>> getAllCachedSubCategories() {
    return _subCategoryDao.watchSubCategories().map(
          (dtos) => dtos.isEmpty
              ? none()
              : some(_subCategoryMapper.fromDbDtoList(dtos)),
        );
  }
}
