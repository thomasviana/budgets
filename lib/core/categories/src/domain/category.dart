import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';
import '../../../../presentation/resources/colors.dart';
import '../../domain.dart';

enum CategoryType { income, expense }

class Category extends CategoryModel {
  final CategoryType type;
  CategoryUserId? categoryUserId;

  Category({
    required CategoryId id,
    required String name,
    required int icon,
    required int color,
    double? amount,
    required this.type,
    this.categoryUserId,
  }) : super(
          id: id,
          name: name,
          icon: icon,
          color: color,
          amount: amount ?? 0,
        );

  // ignore: use_setters_to_change_properties
  void setUserId(String userId) => categoryUserId = CategoryUserId(userId);

  factory Category.housing() => Category(
        id: CategoryId('housing'),
        name: 'Vivienda',
        icon: 0xe318,
        color: CategoryColors.amber,
        type: CategoryType.expense,
      );

  factory Category.food() => Category(
        id: CategoryId('food'),
        name: 'Alimentación',
        icon: 0xe532,
        color: CategoryColors.red,
        type: CategoryType.expense,
      );

  factory Category.transportation() => Category(
        id: CategoryId('transportation'),
        name: 'Transporte',
        icon: 0xf6b2,
        color: CategoryColors.blue_grey,
        type: CategoryType.expense,
      );

  factory Category.healthCare() => Category(
        id: CategoryId('healthCare'),
        name: 'Salud',
        icon: 0xf86f,
        color: CategoryColors.cyan,
        type: CategoryType.expense,
      );

  factory Category.services() => Category(
        id: CategoryId('services'),
        name: 'Servicios',
        icon: 0xe6e7,
        color: CategoryColors.indigo,
        type: CategoryType.expense,
      );

  factory Category.recreation() => Category(
        id: CategoryId('recreation'),
        name: 'Recreación',
        icon: 0xf736,
        color: CategoryColors.purple,
        type: CategoryType.expense,
      );

  factory Category.shopping() => Category(
        id: CategoryId('shopping'),
        name: 'Compras',
        icon: 0xf016f,
        color: CategoryColors.blue,
        type: CategoryType.expense,
      );

  factory Category.financial() => Category(
        id: CategoryId('financial'),
        name: 'Gastos financieros',
        icon: 0xf58f,
        color: CategoryColors.teal,
        type: CategoryType.expense,
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
    double? amount,
    CategoryType? type,
  }) {
    return Category(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        amount: amount ?? this.amount,
        type: type ?? this.type);
  }
}

class CategoryUserId extends AlphanumericId {
  const CategoryUserId(String value) : super(value);

  CategoryUserId.auto() : this(const Uuid().v1());
}
