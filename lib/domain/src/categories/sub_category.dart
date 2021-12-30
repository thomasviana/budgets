import '../../categories.dart';
import '../../core.dart';

class SubCategory extends Entity<CategoryId> {
  late CategoryName _name;
  late String _iconName;
  late int _color;
  late double _totalAmount;
  SubCategory({
    required CategoryId id,
    required CategoryName name,
    required String iconName,
    required int color,
    required double totalAmount,
  }) : super(id) {
    name = _name;
    iconName = _iconName;
    color = _color;
    totalAmount = _totalAmount;
  }

  CategoryName get name => _name;
  String get icon => _iconName;
  int get color => _color;

  void setupdateName(CategoryName newName) => _name = newName;
  void updateIcon(String newIcon) => _iconName = newIcon;
  void updateColor(int newColor) => _color = newColor;

  factory SubCategory.rent() => SubCategory(
        id: CategoryId.auto(),
        name: CategoryName('Arriendo'),
        iconName: 'home',
        color: 0xFFFFD942,
        totalAmount: 0.0,
      );

  factory SubCategory.morgage() => SubCategory(
        id: CategoryId.auto(),
        name: CategoryName('Hipoteca'),
        iconName: 'home',
        color: 0xFFFFD942,
        totalAmount: 0.0,
      );

  factory SubCategory.services() => SubCategory(
        id: CategoryId.auto(),
        name: CategoryName('Servicios Públicos'),
        iconName: 'home',
        color: 0xFFFFD942,
        totalAmount: 0.0,
      );

  factory SubCategory.meats() => SubCategory(
        id: CategoryId.auto(),
        name: CategoryName('Carnes'),
        iconName: 'home',
        color: 0xFFFFD942,
        totalAmount: 0.0,
      );
  factory SubCategory.fruitsAndVegetables() => SubCategory(
        id: CategoryId.auto(),
        name: CategoryName('Frutas y verduras'),
        iconName: 'home',
        color: 0xFFFFD942,
        totalAmount: 0.0,
      );
  factory SubCategory.miscellaneous() => SubCategory(
        id: CategoryId.auto(),
        name: CategoryName('Miscelaneos'),
        iconName: 'home',
        color: 0xFFFFD942,
        totalAmount: 0.0,
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
