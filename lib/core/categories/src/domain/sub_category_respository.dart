import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class SubCategoryRepository {
  Future<Option<List<SubCategory>>> fetchSubCategories(
    CategoryId categoryId,
  );

  Future<void> save(SubCategory subCategory);

  Future<void> saveList(List<SubCategory> subCategories);

  Future<void> delete(CategoryId subCategoryId);
}
