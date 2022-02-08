import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class GetSubCategories {
  final SubCategoryRepository _subCategoryRepository;

  const GetSubCategories(
    this._subCategoryRepository,
  );

  Stream<Option<List<SubCategory>>> call(CategoryId categoryId) =>
      _subCategoryRepository.fetchSubCategories(categoryId);

  Stream<Option<List<SubCategory>>> all() =>
      _subCategoryRepository.fetchAllSubCategories();
}
