import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateBudget {
  final BudgetRepository _budgetRepository;

  const CreateBudget(this._budgetRepository);

  Future<void> call({
    required String name,
    required String? abbreviation,
    required int color,
    required double balance,
    required BudgetUserId budgetUserId,
  }) {
    return _budgetRepository.save(
      Budget(
        id: BudgetId.auto(),
        name: name,
        abbreviation: abbreviation,
        color: color,
        balance: balance,
        budgetUserId: budgetUserId,
      ),
    );
  }
}
