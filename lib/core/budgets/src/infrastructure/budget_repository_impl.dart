import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: BudgetRepository)
class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetsLocalDataSource _budgetslocalDataSource;

  BudgetRepositoryImpl(
    this._budgetslocalDataSource,
  );

  @override
  Stream<Option<List<Budget>>> fetchBudgets(BudgetUserId userId) {
    return _budgetslocalDataSource.getCachedBudgets(userId);
  }

  @override
  Future<void> save(Budget budget) {
    return _budgetslocalDataSource.cacheBudget(budget);
  }

  @override
  Future<void> saveList(List<Budget> budgets) {
    return _budgetslocalDataSource.cacheBudgets(budgets);
  }

  @override
  Future<void> delete(BudgetId budgetId) {
    return _budgetslocalDataSource.deleteBudget(budgetId);
  }

  @override
  Future<void> deleteAll() {
    return _budgetslocalDataSource.deleteAllBudgets();
  }
}
