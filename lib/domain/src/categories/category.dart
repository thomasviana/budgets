import 'package:uuid/uuid.dart';

import '../../categories.dart';
import '../../core.dart';
import 'sub_category.dart';

class Category extends Entity<CategoryId> {
  late CategoryName _name;
  late String _iconName;
  late int _color;
  late double _totalAmount;
  final List<SubCategory> subCategories;
  Category({
    required CategoryId id,
    required CategoryName name,
    required String iconName,
    required int color,
    required double totalAmount,
    required this.subCategories,
  }) : super(id) {
    name = _name;
    iconName = _iconName;
    color = _color;
    totalAmount = _totalAmount;
  }

  CategoryName get name => _name;
  String get icon => _iconName;
  int get color => _color;

  void updateName(CategoryName newName) {
    _name = newName;
  }

  void updateIcon(String newIcon) {
    _iconName = newIcon;
  }

  void updateColor(int newColor) {
    _color = newColor;
  }

  factory Category.housing() => Category(
        id: CategoryId.auto(),
        name: CategoryName('Vivienda'),
        iconName: 'home',
        color: 0xFFFFD426,
        totalAmount: 0.0,
        subCategories: SubCategory.defaultHousingSubCategories,
      );

  factory Category.food() => Category(
        id: CategoryId.auto(),
        name: CategoryName('Alimentación'),
        iconName: 'food_bank',
        color: 0xFFF53914,
        totalAmount: 0.0,
        subCategories: SubCategory.defaultFoodSubCategories,
      );

  factory Category.transportation() => Category(
        id: CategoryId.auto(),
        name: CategoryName('Transporte'),
        iconName: 'car_repair',
        color: 0xFFD4D6D2,
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.healthCare() => Category(
        id: CategoryId.auto(),
        name: CategoryName('Salud'),
        iconName: 'local_hospital',
        color: 0xFFD4D6D2,
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.services() => Category(
        id: CategoryId.auto(),
        name: CategoryName('Servicios'),
        iconName: 'wifi',
        color: 0xFF735AD6,
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.recreation() => Category(
        id: CategoryId.auto(),
        name: CategoryName('Recreación'),
        iconName: 'restaurant',
        color: 0xFFD65CCE,
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.shopping() => Category(
        id: CategoryId.auto(),
        name: CategoryName('Compras'),
        iconName: 'shopping_bag_outlined',
        color: 0xFF47EDFF,
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.financial() => Category(
        id: CategoryId.auto(),
        name: CategoryName('Gastos financieros'),
        iconName: 'money_off',
        color: 0xFF35DB93,
        totalAmount: 0.0,
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

class CategoryId extends AlphanumericId {
  const CategoryId(String value) : super(value);

  CategoryId.auto() : this(const Uuid().v1());
}
