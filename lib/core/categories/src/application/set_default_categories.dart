import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class SetDefaultCategories {
  final GetProfileInfo _getProfileInfo;
  final CategoryRepository _categoryRepository;

  const SetDefaultCategories(
    this._getProfileInfo,
    this._categoryRepository,
  );

  Future<void> call() async {
    final user = await _getProfileInfo().first;

    if (user != null) {
      final categories = Category.defaultCategories;
      for (final category in categories) {
        category.setUserId(user.id.value);
      }
      _categoryRepository.saveList(categories);
    }
  }
}
