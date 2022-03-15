import 'package:injectable/injectable.dart';

import '../../application.dart';
import '../../domain.dart';

@injectable
class UpdateCategory {
  final CategoryRepository _categoryRepository;
  final GetCategories _getCategories;

  const UpdateCategory(
    this._categoryRepository,
    this._getCategories,
  );

  Future<void> call({
    required CategoryId categoryId,
    String? name,
    int? icon,
    int? color,
    double? amount,
  }) async {
    final category = await _getCategories().first.then(
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
  }
}
