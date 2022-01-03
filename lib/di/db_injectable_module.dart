import 'package:budgets/core/categories/infrastructure.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DbInjectableModule {
  @lazySingleton
  CategoriesDatabase get categoriesDatabase => CategoriesDatabase();
}
