import 'package:budgets/core/categories/src/domain/category_model.dart';

import 'category.dart';

class SubCategory extends CategoryModel {
  final CategoryId parentCategoryId;
  SubCategory({
    required CategoryId id,
    required this.parentCategoryId,
    required String name,
    required int icon,
    required int color,
  }) : super(id: id, name: name, icon: icon, color: color);

  factory SubCategory.rent() => SubCategory(
        id: CategoryId.auto(),
        parentCategoryId: Category.housing().id,
        name: 'Arriendo',
        icon: Category.housing().icon,
        color: Category.housing().color,
      );

  factory SubCategory.morgage() => SubCategory(
        id: CategoryId.auto(),
        parentCategoryId: Category.housing().id,
        name: 'Hipoteca',
        icon: Category.housing().icon,
        color: Category.housing().color,
      );

  factory SubCategory.services() => SubCategory(
        id: CategoryId.auto(),
        parentCategoryId: Category.housing().id,
        name: 'Servicios Públicos',
        icon: Category.housing().icon,
        color: Category.housing().color,
      );

  factory SubCategory.meats() => SubCategory(
        id: CategoryId.auto(),
        parentCategoryId: Category.food().id,
        name: 'Carnes',
        icon: Category.food().icon,
        color: Category.food().color,
      );
  factory SubCategory.fruitsAndVegetables() => SubCategory(
        id: CategoryId.auto(),
        parentCategoryId: Category.food().id,
        name: 'Frutas y verduras',
        icon: Category.food().icon,
        color: Category.food().color,
      );
  factory SubCategory.miscellaneous() => SubCategory(
        id: CategoryId.auto(),
        parentCategoryId: Category.food().id,
        name: 'Miscelaneos',
        icon: Category.food().icon,
        color: Category.food().color,
      );

  static List<SubCategory> get defaultHousingSubCategories {
    return [
      SubCategory.rent(),
      SubCategory.morgage(),
      SubCategory.services(),
    ];
  }

  static List<SubCategory> get defaultFoodSubCategories {
    return [
      SubCategory.meats(),
      SubCategory.fruitsAndVegetables(),
      SubCategory.miscellaneous(),
    ];
  }
}
