import 'package:injectable/injectable.dart';

import '../../application.dart';
import '../../domain.dart';

@injectable
class UpdateSubCategory {
  final SubCategoryRepository _subCategoryRepository;
  final GetSubCategories _getSubCategories;

  const UpdateSubCategory(
    this._subCategoryRepository,
    this._getSubCategories,
  );

  Future<void> call({
    required CategoryId categoryId,
    required CategoryId subCategorId,
    String? name,
    int? icon,
    int? color,
    double? amount,
  }) async {
    final subCategory = await _getSubCategories(categoryId).first.then(
          (subCategories) => subCategories.fold(
            () => null,
            (subCategories) => subCategories.firstWhere(
              (subCategory) => subCategory.id == subCategorId,
              orElse: () => throw Exception("Category doesn't exist."),
            ),
          ),
        );
    if (subCategory != null) {
      _subCategoryRepository.save(
        subCategory.copyWith(
          name: name,
          icon: icon,
          color: color,
          balance: subCategory.balance + (amount ?? 0),
        ),
      );
    }
  }
}
