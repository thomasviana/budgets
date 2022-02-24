import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateCategory {
  final CategoryRepository _categoryRepository;
  final GetProfileInfo _getProfileInfo;

  const CreateCategory(
    this._categoryRepository,
    this._getProfileInfo,
  );

  Future<void> call({
    required String name,
    required int icon,
    required int color,
    required CategoryType type,
  }) async {
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) {
          _categoryRepository.save(
            Category(
              id: CategoryId.auto(),
              name: name,
              icon: icon,
              color: color,
              type: type,
              categoryUserId: CategoryUserId(user.id.value),
            ),
          );
        },
      ),
    );
  }
}
