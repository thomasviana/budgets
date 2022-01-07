import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

@lazySingleton
class SubCategoryMapper {
  const SubCategoryMapper();

  SubCategory fromDbDto(SubCategoryDbDto dto) {
    final id = CategoryId(dto.id);
    final categoryId = CategoryId(dto.cateogryId);

    return SubCategory(
      id: id,
      name: dto.name,
      icon: dto.icon,
      color: dto.color,
      amount: dto.amount,
      categoryId: categoryId,
    );
  }

  List<SubCategory> fromDbDtoList(List<SubCategoryDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  SubCategoriesTableCompanion toDbDto(SubCategory subCategory) {
    return SubCategoriesTableCompanion(
        id: Value(subCategory.id.value),
        name: Value(subCategory.name),
        icon: Value(subCategory.icon),
        color: Value(subCategory.color),
        amount: Value(subCategory.amount),
        cateogryId: Value(subCategory.categoryId.value));
  }

  List<SubCategoriesTableCompanion> toDbDtoList(
      List<SubCategory> subCategories) {
    return subCategories.map((subCategory) => toDbDto(subCategory)).toList();
  }
}
