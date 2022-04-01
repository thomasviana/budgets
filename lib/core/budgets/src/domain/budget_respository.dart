import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class BudgetRepository {
  Stream<Option<List<Budget>>> fetchBudgets(
    BudgetUserId userId,
  );

  Future<void> save(Budget budget);

  Future<void> saveList(List<Budget> budgets);

  Future<void> delete(BudgetId budgetId);

  Future<void> deleteAll();
}
