import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import 'categories_db.dart';

@lazySingleton
class CategoryMapper {
  const CategoryMapper();

  Category fromDbDto(CategoryDbDto dto) {
    final id = CategoryId(dto.id);
    final userId = CategoryUserId(dto.userId!);

    return Category(
      id: id,
      categoryUserId: userId,
      name: dto.name,
      color: dto.color,
      icon: dto.icon,
      subCategories: [], //TODO: Subcategories
    );
  }

  List<Category> fromDbDtoList(List<CategoryDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  CategoryTableCompanion toDbDto(Category category) {
    return CategoryTableCompanion(
      id: Value(category.id.value),
      userId: Value(category.categoryUserId!.value),
      name: Value(category.name),
      color: Value(category.color),
      icon: Value(category.icon),
    );
  }

  List<CategoryTableCompanion> toDbDtoList(List<Category> categories) {
    return categories.map((category) => toDbDto(category)).toList();
  }
}
