import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class GetBudgets {
  final BudgetRepository _budgetRepository;

  const GetBudgets(
    this._budgetRepository,
  );

  Stream<Option<List<Budget>>> call(BudgetUserId userId) =>
      _budgetRepository.fetchBudgets(userId);
}
