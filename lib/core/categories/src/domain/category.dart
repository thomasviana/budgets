import '../../../../presentation/resources/colors.dart';
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
        color: CategoryColors.amber,
        subCategories: SubCategory.housingSubCategories,
      );

  factory Category.food() => Category(
        id: CategoryId.auto(),
        name: 'Alimentación',
        icon: 0xe532,
        color: CategoryColors.red,
        subCategories: SubCategory.foodSubCategories,
      );

  factory Category.transportation() => Category(
        id: CategoryId.auto(),
        name: 'Transporte',
        icon: 0xf6b2,
        color: CategoryColors.blue_grey,
        subCategories: SubCategory.transportationSubCategories,
      );

  factory Category.healthCare() => Category(
        id: CategoryId.auto(),
        name: 'Salud',
        icon: 0xf86f,
        color: CategoryColors.cyan,
        subCategories: SubCategory.healthCareSubCategories,
      );

  factory Category.services() => Category(
        id: CategoryId.auto(),
        name: 'Servicios',
        icon: 0xe6e7,
        color: CategoryColors.indigo,
        subCategories: SubCategory.servicesSubCategories,
      );

  factory Category.recreation() => Category(
        id: CategoryId.auto(),
        name: 'Recreación',
        icon: 0xf736,
        color: CategoryColors.green,
        subCategories: SubCategory.recreationSubCategories,
      );

  factory Category.shopping() => Category(
        id: CategoryId.auto(),
        name: 'Compras',
        icon: 0xf016f,
        color: CategoryColors.blue,
        subCategories: SubCategory.shoppingSubCategories,
      );

  factory Category.financial() => Category(
        id: CategoryId.auto(),
        name: 'Gastos financieros',
        icon: 0xf58f,
        color: CategoryColors.teal,
        subCategories: SubCategory.financialSubCategories,
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

  Category copyWith({
    CategoryId? id,
    String? name,
    int? icon,
    int? color,
    List<SubCategory>? subCategories,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}
