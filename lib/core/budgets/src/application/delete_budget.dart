import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class DeleteBudget {
  final BudgetRepository _budgetRepository;

  const DeleteBudget(this._budgetRepository);

  Future<void> call(BudgetId budgetId) {
    return _budgetRepository.delete(budgetId);
  }
}
