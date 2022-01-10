import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';
import '../../../../presentation/resources/colors.dart';

enum BudgetAbbreviation { bank, cash, wallet }

class Budget extends Entity<BudgetId> {
  String name;
  String? abbreviation;
  int color;
  double balance;
  BudgetUserId? budgetUserId;

  Budget({
    required BudgetId id,
    required this.name,
    this.abbreviation,
    required this.color,
    this.balance = 0,
    this.budgetUserId,
  }) : super(id);

  // ignore: use_setters_to_change_properties
  void setUserId(String userId) => budgetUserId = BudgetUserId(userId);
  // ignore: use_setters_to_change_properties
  void updateName(String newName) => name = newName;
  // ignore: use_setters_to_change_properties
  void updateAbbreviation(String? newAbbreviation) =>
      abbreviation = newAbbreviation;
  // ignore: use_setters_to_change_properties
  void updateColor(int newColor) => color = newColor;
  // ignore: use_setters_to_change_properties
  void updateBalance(double newBalance) => balance = newBalance;

  factory Budget.empty() => Budget(
        id: BudgetId.auto(),
        name: '',
        abbreviation: '',
        color: AppColors.primaryColor.value,
      );

  factory Budget.inv() => Budget(
        id: BudgetId('inv'),
        name: 'Inversiones',
        abbreviation: 'INV',
        color: AppColors.primaryColor.value,
      );
  factory Budget.seg() => Budget(
        id: BudgetId('seg'),
        name: 'Seguridad',
        abbreviation: 'SEG',
        color: AppColors.primaryColor.value,
      );
  factory Budget.dar() => Budget(
        id: BudgetId('dar'),
        name: 'Contribución',
        abbreviation: 'DAR',
        color: AppColors.primaryColor.value,
      );
  factory Budget.gap() => Budget(
        id: BudgetId('gap'),
        name: 'Gastos Anuales Programados',
        abbreviation: 'GAP',
        color: AppColors.primaryColor.value,
      );
  factory Budget.sos() => Budget(
        id: BudgetId('sos'),
        name: 'Imprevistos',
        abbreviation: 'SOS',
        color: AppColors.primaryColor.value,
      );
  factory Budget.div() => Budget(
        id: BudgetId('div'),
        name: 'Diversión',
        abbreviation: 'DIV',
        color: AppColors.primaryColor.value,
      );
  factory Budget.rel() => Budget(
        id: BudgetId('rel'),
        name: 'Relaciones',
        abbreviation: 'REL',
        color: AppColors.primaryColor.value,
      );
  factory Budget.sue() => Budget(
        id: BudgetId('sue'),
        name: 'Sueños',
        abbreviation: 'SUE',
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
