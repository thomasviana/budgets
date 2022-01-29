import 'package:injectable/injectable.dart';

import '../../application.dart';
import '../../domain.dart';

@injectable
class UpdateBudget {
  final BudgetRepository _budgetRepository;
  final GetBudgets _getBudgets;

  const UpdateBudget(
    this._budgetRepository,
    this._getBudgets,
  );

  Future<void> call({
    required BudgetUserId userId,
    required BudgetId budgetId,
    String? name,
    String? abbreviation,
    int? color,
    double? balance,
  }) async {
    final budget = await _getBudgets(userId).first.then(
          (budgets) => budgets.fold(
            () => null,
            (budgets) => budgets.firstWhere(
              (budget) => budget.id == budgetId,
              orElse: () => throw Exception("Budget doesn't exist."),
            ),
          ),
        );
    if (budget != null) {
      _budgetRepository.save(
        budget
          ..updateName(name ?? budget.name)
          ..updateAbbreviation(abbreviation ?? budget.abbreviation)
          ..updateColor(color ?? budget.color)
          ..updateBalance(balance ?? budget.balance),
      );
    }
  }
}
