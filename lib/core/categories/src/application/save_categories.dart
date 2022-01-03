import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class SaveCategories {
  final CategoryRepository _categoryRepository;

  const SaveCategories(this._categoryRepository);

  Future<void> call({
    required List<Category> categories,
  }) {
    return _categoryRepository.saveList(categories);
  }
}
