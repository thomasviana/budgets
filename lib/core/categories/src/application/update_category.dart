import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

import '../../application.dart';
import '../../domain.dart';

@injectable
class UpdateCategory {
  final CategoryRepository _categoryRepository;
  final GetCategories _getCategories;
  final GetProfileInfo _getProfileInfo;

  const UpdateCategory(
    this._categoryRepository,
    this._getCategories,
    this._getProfileInfo,
  );

  Future<void> call({
    required CategoryId categoryId,
    String? name,
    int? icon,
    int? color,
    double? amount,
  }) async {
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) async {
          final category = await _getCategories(CategoryUserId(user.id.value))
              .first
              .then(
                (categories) => categories.fold(
                  () => null,
                  (categories) => categories.firstWhere(
                    (category) => category.id == categoryId,
                    orElse: () => throw Exception("Category doesn't exist."),
                  ),
                ),
              );
          if (category != null) {
            _categoryRepository.save(
              category.copyWith(
                name: name,
                icon: icon,
                color: color,
                balance: category.balance + (amount ?? 0),
              ),
            );
          }
        },
      ),
    );
  }
}
