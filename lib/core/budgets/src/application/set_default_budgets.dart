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
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) {
          final budgets = Budget.defaultBudgets;
          for (final budget in budgets) {
            budget.setUserId(user.id.value);
          }
          _budgetRepository.saveList(budgets);
        },
      ),
    );
  }
}
