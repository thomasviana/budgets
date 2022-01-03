import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateCategory {
  final CategoryRepository _categoryRepository;

  const CreateCategory(this._categoryRepository);

  Future<void> call({
    required CategoryUserId categoryUserId,
    required String name,
    required int icon,
    required int color,
  }) {
    return _categoryRepository.save(Category(
      id: CategoryId.auto(),
      name: name,
      icon: icon,
      color: color,
      subCategories: [],
    ));
  }
}
