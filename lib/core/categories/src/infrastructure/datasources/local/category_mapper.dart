import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

@lazySingleton
class CategoryMapper {
  const CategoryMapper();

  Category fromDbDto(CategoryDbDto dto) {
    final id = CategoryId(dto.id);
    final userId = CategoryUserId(dto.userId!);
    final categoryType = CategoryType.values[dto.type.index];

    return Category(
      id: id,
      categoryUserId: userId,
      name: dto.name,
      icon: dto.icon,
      color: dto.color,
      amount: dto.amount,
      type: categoryType,
    );
  }

  List<Category> fromDbDtoList(List<CategoryDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  CategoriesTableCompanion toDbDto(Category category) {
    final categoryType = CategoryTypeTable.values[category.type.index];
    return CategoriesTableCompanion(
      id: Value(category.id.value),
      name: Value(category.name),
      icon: Value(category.icon),
      color: Value(category.color),
      amount: Value(category.amount),
      type: Value(categoryType),
      userId: Value(category.categoryUserId!.value),
    );
  }

  List<CategoriesTableCompanion> toDbDtoList(List<Category> categories) {
    return categories.map((category) => toDbDto(category)).toList();
  }
}
