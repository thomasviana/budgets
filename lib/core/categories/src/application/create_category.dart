import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateCategory {
  final CategoryRepository _categoryRepository;

  const CreateCategory(this._categoryRepository);

  Future<void> call({
    required String name,
    required int icon,
    required int color,
    required CategoryType type,
    required CategoryUserId categoryUserId,
  }) {
    return _categoryRepository.save(
      Category(
        id: CategoryId.auto(),
        name: name,
        icon: icon,
        color: color,
        type: type,
        categoryUserId: categoryUserId,
      ),
    );
  }
}
