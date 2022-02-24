import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

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
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) {
          final categories = Category.defaultCategories;
          for (final category in categories) {
            category.setUserId(user.id.value);
          }
          _categoryRepository.saveList(categories);
        },
      ),
    );
  }
}
