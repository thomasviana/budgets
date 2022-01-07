import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class SaveSubCategories {
  final SubCategoryRepository _subCategoryRepository;

  const SaveSubCategories(this._subCategoryRepository);

  Future<void> call({
    required List<SubCategory> subCategories,
  }) {
    return _subCategoryRepository.saveList(subCategories);
  }
}
