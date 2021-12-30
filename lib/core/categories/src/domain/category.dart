import 'category_model.dart';
import 'sub_category.dart';

class Category extends CategoryModel {
  List<SubCategory> subCategories;

  Category({
    required CategoryId id,
    required String name,
    required int icon,
    required int color,
    required this.subCategories,
  }) : super(id: id, name: name, icon: icon, color: color);

  factory Category.housing() => Category(
        id: CategoryId.auto(),
        name: 'Vivienda',
        icon: 0xe318,
        color: 0xFFFFD426,
        subCategories: SubCategory.defaultHousingSubCategories,
      );

  factory Category.food() => Category(
        id: CategoryId.auto(),
        name: 'Alimentación',
        icon: 0xf784,
        color: 0xFFF53914,
        subCategories: SubCategory.defaultFoodSubCategories,
      );

  factory Category.transportation() => Category(
        id: CategoryId.auto(),
        name: 'Transporte',
        icon: 0xf6b2,
        color: 0xFFD4D6D2,
        subCategories: [],
      );

  factory Category.healthCare() => Category(
        id: CategoryId.auto(),
        name: 'Salud',
        icon: 0xf86f,
        color: 0xFFD4D6D2,
        subCategories: [],
      );

  factory Category.services() => Category(
        id: CategoryId.auto(),
        name: 'Servicios',
        icon: 0xe6e7,
        color: 0xFF735AD6,
        subCategories: [],
      );

  factory Category.recreation() => Category(
        id: CategoryId.auto(),
        name: 'Recreación',
        icon: 0xe532,
        color: 0xFFD65CCE,
        subCategories: [],
      );

  factory Category.shopping() => Category(
        id: CategoryId.auto(),
        name: 'Compras',
        icon: 0xf37d,
        color: 0xFF47EDFF,
        subCategories: [],
      );

  factory Category.financial() => Category(
        id: CategoryId.auto(),
        name: 'Gastos financieros',
        icon: 0xf58f,
        color: 0xFF35DB93,
        subCategories: [],
      );

  static List<Category> get defaultCategories {
    return [
      Category.housing(),
      Category.food(),
      Category.transportation(),
      Category.healthCare(),
      Category.services(),
      Category.recreation(),
      Category.shopping(),
      Category.financial(),
    ];
  }
}
