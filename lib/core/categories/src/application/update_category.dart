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
    required CategoryUserId userId,
    required CategoryId categoryId,
    String? name,
    int? icon,
    int? color,
  }) async {
    final category = await _getCategories(userId).then(
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
        category
          ..updateName(name ?? category.name)
          ..updateIcon(icon ?? category.icon)
          ..updateColor(color ?? category.color),
      );
    }
  }
}
