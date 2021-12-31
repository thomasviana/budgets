import '../../domain.dart';
import '../../infrastructure.dart';

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
      //TODO: Subcategories
      subCategories: [],
    );
  }

  List<Category> fromDbDtoList(List<CategoryDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  CategoryDbDto toDbDto(Category category) {
    return CategoryDbDto(
      id: category.id.value,
      userId: category.categoryUserId!.value,
      name: category.name,
      color: category.color,
      icon: category.icon,
    );
  }
}
