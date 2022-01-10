import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class SaveBudgets {
  final BudgetRepository _budgetRepository;

  const SaveBudgets(this._budgetRepository);

  Future<void> call({
    required List<Budget> budgets,
  }) {
    return _budgetRepository.saveList(budgets);
  }
}
