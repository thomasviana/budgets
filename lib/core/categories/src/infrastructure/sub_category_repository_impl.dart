import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: SubCategoryRepository)
class SubCategoryRepositoryImpl implements SubCategoryRepository {
  final LocalDataSource _localDataSource;

  SubCategoryRepositoryImpl(
    this._localDataSource,
  );

  @override
  Future<void> delete(CategoryId subCategoryId) {
    return _localDataSource.deleteSubCategory(subCategoryId);
  }

  @override
  Future<void> save(SubCategory subCategory) {
    return _localDataSource.cacheSubCategory(subCategory);
  }

  @override
  Future<void> saveList(List<SubCategory> subCategories) {
    return _localDataSource.cacheSubCategories(subCategories);
  }

  @override
  Future<Option<List<SubCategory>>> fetchSubCategories(CategoryId categoryId) {
    return _localDataSource.getCachedSubCategories(categoryId);
  }
}
