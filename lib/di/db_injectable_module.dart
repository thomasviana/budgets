import 'package:injectable/injectable.dart';

import '../core/accounts/infrastructure.dart';
import '../core/budgets/infrastructure.dart';
import '../core/categories/infrastructure.dart';

@module
abstract class DbInjectableModule {
  @lazySingleton
  CategoriesDatabase get categoriesDatabase => CategoriesDatabase();
  @lazySingleton
  AccountsDatabase get accountsDatabase => AccountsDatabase();
  @lazySingleton
  BudgetsDatabase get budgetsDatabase => BudgetsDatabase();
}
