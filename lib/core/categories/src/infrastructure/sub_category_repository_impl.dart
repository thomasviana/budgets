import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: SubCategoryRepository)
class SubCategoryRepositoryImpl implements SubCategoryRepository {
  final CategoriesLocalDataSource _categoriesLocalDataSource;

  SubCategoryRepositoryImpl(
    this._categoriesLocalDataSource,
  );

  @override
  Future<void> delete(CategoryId subCategoryId) {
    return _categoriesLocalDataSource.deleteSubCategory(subCategoryId);
  }

  @override
  Future<void> save(SubCategory subCategory) {
    return _categoriesLocalDataSource.cacheSubCategory(subCategory);
  }

  @override
  Future<void> saveList(List<SubCategory> subCategories) {
    return _categoriesLocalDataSource.cacheSubCategories(subCategories);
  }

  @override
  Stream<Option<List<SubCategory>>> fetchSubCategories(CategoryId categoryId) {
    return _categoriesLocalDataSource.getCachedSubCategories(categoryId);
  }

  @override
  Stream<Option<List<SubCategory>>> fetchAllSubCategories() {
    return _categoriesLocalDataSource.getAllCachedSubCategories();
  }
}
