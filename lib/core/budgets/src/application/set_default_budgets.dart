import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class SetDefaultBudgets {
  final BudgetRepository _budgetRepository;
  final GetProfileInfo _getProfileInfo;

  const SetDefaultBudgets(
    this._budgetRepository,
    this._getProfileInfo,
  );

  Future<void> call() async {
    final user = await _getProfileInfo().first;
    if (user != null) {
      final budgets = Budget.defaultBudgets;
      for (final budget in budgets) {
        budget.setUserId(user.id.value);
      }
      _budgetRepository.saveList(budgets);
    }
  }
}
