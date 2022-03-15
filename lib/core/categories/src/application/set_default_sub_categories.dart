import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class SetDefaultSubCategories {
  final SubCategoryRepository _subCategoryRepository;

  const SetDefaultSubCategories(
    this._subCategoryRepository,
  );

  Future<void> call() async {
    final subCategories = SubCategory.allSubCategories;
    _subCategoryRepository.saveList(subCategories);
  }
}
