import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';
import '../../../../presentation/resources/colors.dart';
import '../../domain.dart';

enum CategoryType { expense, income }

class Category extends CategoryModel {
  CategoryType type;
  CategoryUserId? categoryUserId;

  Category({
    required CategoryId id,
    String name = '',
    required int icon,
    required int color,
    double? balance,
    required this.type,
    this.categoryUserId,
  }) : super(
          id: id,
          name: name,
          icon: icon,
          color: color,
          balance: balance ?? 0,
        );

  Category copyWith({
    String? name,
    int? icon,
    int? color,
    double? balance,
    CategoryType? type,
    CategoryUserId? categoryUserId,
  }) {
    return Category(
      id: id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      categoryUserId: categoryUserId ?? this.categoryUserId,
    );
  }

  void setUserId(String userId) => categoryUserId = CategoryUserId(userId);

  factory Category.empty() => Category(
        id: CategoryId.auto(),
        icon: 0xe5f9,
        color: AppColors.primaryColor.value,
        type: CategoryType.expense,
      );

  // Expense Categories

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
        name: 'Diversión',
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
        color: CategoryColors.green,
        type: CategoryType.expense,
      );

  factory Category.education() => Category(
        id: CategoryId('education'),
        name: 'Educación',
        icon: 63568,
        color: CategoryColors.deep_purple,
        type: CategoryType.expense,
      );

  factory Category.contribution() => Category(
        id: CategoryId('contribution'),
        name: 'Contribución',
        icon: 983707,
        color: CategoryColors.pink,
        type: CategoryType.expense,
      );

  factory Category.dependents() => Category(
        id: CategoryId('dependents'),
        name: 'Dependientes',
        icon: 63036,
        color: CategoryColors.orange,
        type: CategoryType.expense,
      );

  factory Category.investments() => Category(
        id: CategoryId('investments'),
        name: 'Inversiones',
        icon: 63513,
        color: CategoryColors.teal,
        type: CategoryType.expense,
      );

  // Income Categories

  factory Category.salary() => Category(
        id: CategoryId('salary'),
        name: 'Salario',
        icon: 0xf58f,
        color: CategoryColors.amber,
        type: CategoryType.income,
      );

  factory Category.honorarium() => Category(
        id: CategoryId('honorarium'),
        name: 'Honorarios',
        icon: 0xf58f,
        color: CategoryColors.red,
        type: CategoryType.income,
      );

  factory Category.rental() => Category(
        id: CategoryId('rental'),
        name: 'Renta de capital',
        icon: 0xf58f,
        color: CategoryColors.blue_grey,
        type: CategoryType.income,
      );

  factory Category.business() => Category(
        id: CategoryId('business'),
        name: 'Negocios',
        icon: 0xf58f,
        color: CategoryColors.cyan,
        type: CategoryType.income,
      );

  factory Category.dividends() => Category(
        id: CategoryId('dividends'),
        name: 'Dividendos',
        icon: 0xf58f,
        color: CategoryColors.indigo,
        type: CategoryType.income,
      );

  factory Category.pension() => Category(
        id: CategoryId('pension'),
        name: 'Pensión',
        icon: 0xf58f,
        color: CategoryColors.purple,
        type: CategoryType.income,
      );

  factory Category.occasional() => Category(
        id: CategoryId('occasional'),
        name: 'Ocasional',
        icon: 0xf58f,
        color: CategoryColors.blue,
        type: CategoryType.income,
      );

  factory Category.gift() => Category(
        id: CategoryId('gift'),
        name: 'Regalos',
        icon: 0xf58f,
        color: CategoryColors.teal,
        type: CategoryType.income,
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
      Category.education(),
      Category.contribution(),
      Category.dependents(),
      Category.investments(),
      Category.salary(),
      Category.honorarium(),
      Category.rental(),
      Category.business(),
      Category.dividends(),
      Category.pension(),
      Category.occasional(),
      Category.gift(),
    ];
  }
}

class CategoryUserId extends AlphanumericId {
  const CategoryUserId(String value) : super(value);

  CategoryUserId.auto() : this(const Uuid().v1());
}
