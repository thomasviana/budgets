import 'package:budgets/core/accounts/infrastructure.dart';
import 'package:injectable/injectable.dart';

import '../core/categories/infrastructure.dart';

@module
abstract class DbInjectableModule {
  @lazySingleton
  CategoriesDatabase get categoriesDatabase => CategoriesDatabase();
  @lazySingleton
  AccountsDatabase get accountsDatabase => AccountsDatabase();
}
