import 'package:budgets/presentation/resources/colors.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';

enum BudgetIcon { bank, cash, wallet }

class Budget extends Entity<BudgetId> {
  String name;
  int icon;
  int color;
  double balance;
  BudgetUserId? budgetUserId;

  Budget({
    required BudgetId id,
    required this.name,
    required this.icon,
    required this.color,
    this.balance = 0,
    this.budgetUserId,
  }) : super(id);

  // ignore: use_setters_to_change_properties
  void setUserId(String userId) => budgetUserId = BudgetUserId(userId);
  // ignore: use_setters_to_change_properties
  void updateName(String newName) => name = newName;
  // ignore: use_setters_to_change_properties
  void updateIcon(int newIcon) => icon = newIcon;
  // ignore: use_setters_to_change_properties
  void updateColor(int newColor) => color = newColor;
  // ignore: use_setters_to_change_properties
  void updateBalance(double newBalance) => balance = newBalance;

  String get abbreviation {
    if (id == BudgetId('inv')) return 'INV';
    if (id == BudgetId('seg')) return 'SEG';
    if (id == BudgetId('dar')) return 'DAR';
    if (id == BudgetId('gap')) return 'GAP';
    if (id == BudgetId('sos')) return 'SOS';
    if (id == BudgetId('div')) return 'DIV';
    if (id == BudgetId('rel')) return 'REL';
    if (id == BudgetId('sue')) return 'SUE';
    return '';
  }

  factory Budget.empty() => Budget(
        id: BudgetId.auto(),
        name: '',
        icon: 0xe33a,
        color: AppColors.primaryColor.value,
      );

  factory Budget.inv() => Budget(
        id: BudgetId('inv'),
        name: 'Inversiones',
        icon: 0xe33a,
        color: AppColors.primaryColor.value,
      );
  factory Budget.seg() => Budget(
        id: BudgetId('seg'),
        name: 'Seguridad',
        icon: 0xe33a,
        color: AppColors.primaryColor.value,
      );
  factory Budget.dar() => Budget(
        id: BudgetId('dar'),
        name: 'Contribución',
        icon: 0xe33a,
        color: AppColors.primaryColor.value,
      );
  factory Budget.gap() => Budget(
        id: BudgetId('gap'),
        name: 'Gastos Anuales Programados',
        icon: 0xe33a,
        color: AppColors.primaryColor.value,
      );
  factory Budget.sos() => Budget(
        id: BudgetId('sos'),
        name: 'Imprevistos',
        icon: 0xe33a,
        color: AppColors.primaryColor.value,
      );
  factory Budget.div() => Budget(
        id: BudgetId('div'),
        name: 'Diversión',
        icon: 0xe33a,
        color: AppColors.primaryColor.value,
      );
  factory Budget.rel() => Budget(
        id: BudgetId('rel'),
        name: 'Relaciones',
        icon: 0xe33a,
        color: AppColors.primaryColor.value,
      );
  factory Budget.sue() => Budget(
        id: BudgetId('sue'),
        name: 'Sueños',
        icon: 0xe33a,
        color: AppColors.primaryColor.value,
      );

  static List<Budget> get defaultBudgets {
    return [
      Budget.inv(),
      Budget.seg(),
      Budget.dar(),
      Budget.gap(),
      Budget.sos(),
      Budget.div(),
      Budget.rel(),
      Budget.sue(),
    ];
  }
}

class BudgetId extends AlphanumericId {
  const BudgetId(String value) : super(value);

  BudgetId.auto() : this(const Uuid().v1());
}

class BudgetUserId extends AlphanumericId {
  const BudgetUserId(String value) : super(value);

  BudgetUserId.auto() : this(const Uuid().v1());
}
