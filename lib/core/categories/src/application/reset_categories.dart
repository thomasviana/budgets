import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class ResetCategories {
  final CategoryRepository _categoryRepository;
  final SubCategoryRepository _subCategoryRepository;

  const ResetCategories(
    this._categoryRepository,
    this._subCategoryRepository,
  );

  Future<void> call() async {
    _categoryRepository.deleteAll();
    _subCategoryRepository.deleteAll();
  }
}
