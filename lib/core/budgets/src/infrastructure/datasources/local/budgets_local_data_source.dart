import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class BudgetsLocalDataSource {
  Future<void> cacheBudget(Budget budget);
  Future<void> cacheBudgets(List<Budget> budgets);
  Stream<Option<List<Budget>>> getCachedBudgets(BudgetUserId userId);
  Future<void> deleteBudget(BudgetId budgetId);
}

@LazySingleton(as: BudgetsLocalDataSource)
class BudgetsLocalDataSourceImpl implements BudgetsLocalDataSource {
  final BudgetDao _budgetDao;
  final BudgetMapper _budgetMapper;

  BudgetsLocalDataSourceImpl(
    this._budgetDao,
    this._budgetMapper,
  );

  @override
  Future<void> cacheBudget(Budget budget) {
    return Future.value(_budgetMapper.toDbDto(budget))
        .then((campanion) => _budgetDao.createOrUpdate(campanion));
  }

  @override
  Future<void> cacheBudgets(List<Budget> budgets) {
    return Future.value(_budgetMapper.toDbDtoList(budgets)).then(
      (campanions) => {
        for (var campanion in campanions) {_budgetDao.createOrUpdate(campanion)}
      },
    );
  }

  @override
  Future<void> deleteBudget(BudgetId budgetId) {
    return _budgetDao.deleteBudget(budgetId.value);
  }

  @override
  Stream<Option<List<Budget>>> getCachedBudgets(
    BudgetUserId userId,
  ) =>
      _budgetDao.getBudgets(userId.value).map((dtos) =>
          dtos.isEmpty ? none() : some(_budgetMapper.fromDbDtoList(dtos)));
}
