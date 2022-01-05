import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateSubCategory {
  final SubCategoryRepository _subCategoryRepository;

  const CreateSubCategory(this._subCategoryRepository);

  Future<void> call({
    required String name,
    required int icon,
    required int color,
    required CategoryId categoryId,
  }) {
    return _subCategoryRepository.save(
      SubCategory(
        id: CategoryId.auto(),
        name: name,
        icon: icon,
        color: color,
        categoryId: categoryId,
      ),
    );
  }
}
