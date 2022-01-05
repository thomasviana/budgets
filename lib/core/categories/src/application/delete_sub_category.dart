import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class DeleteSubCategory {
  final SubCategoryRepository _subCategoryRepository;

  const DeleteSubCategory(this._subCategoryRepository);

  Future<void> call(CategoryId subCategoryId) {
    return _subCategoryRepository.delete(subCategoryId);
  }
}
