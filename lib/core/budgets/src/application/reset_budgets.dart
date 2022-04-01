import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class ResetBudgets {
  final BudgetRepository _budgetRepository;

  const ResetBudgets(
    this._budgetRepository,
  );

  Future<void> call() async {
    _budgetRepository.deleteAll();
  }
}
