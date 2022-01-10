import 'package:budgets/core/accounts/infrastructure.dart';
import 'package:budgets/core/budgets/infrastructure.dart';
import 'package:budgets/core/categories/infrastructure.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DbInjectableModule {
  @lazySingleton
  CategoriesDatabase get categoriesDatabase => CategoriesDatabase();
  @lazySingleton
  AccountsDatabase get accountsDatabase => AccountsDatabase();
  @lazySingleton
  BudgetsDatabase get budgetsDatabase => BudgetsDatabase();
}
