import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

import '../../application.dart';
import '../../domain.dart';

@injectable
class UpdateBudget {
  final BudgetRepository _budgetRepository;
  final GetBudgets _getBudgets;
  final GetProfileInfo _getProfileInfo;

  const UpdateBudget(
    this._budgetRepository,
    this._getBudgets,
    this._getProfileInfo,
  );

  Future<void> call({
    required BudgetId budgetId,
    String? name,
    String? abbreviation,
    int? color,
    double? amount,
  }) async {
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) async {
          final budget =
              await _getBudgets(BudgetUserId(user.id.value)).first.then(
                    (budgets) => budgets.fold(
                      () {},
                      (budgets) => budgets.firstWhere(
                        (budget) => budget.id == budgetId,
                        orElse: () => throw Exception("Budget doesn't exist."),
                      ),
                    ),
                  );
          if (budget != null) {
            _budgetRepository.save(
              budget.copyWith(
                name: name,
                abbreviation: abbreviation,
                color: color,
                balance: budget.balance + (amount ?? 0),
              ),
            );
          }
        },
      ),
    );
  }
}
