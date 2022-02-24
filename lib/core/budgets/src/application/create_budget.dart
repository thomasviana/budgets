import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateBudget {
  final BudgetRepository _budgetRepository;
  final GetProfileInfo _getProfileInfo;

  const CreateBudget(
    this._budgetRepository,
    this._getProfileInfo,
  );

  Future<void> call({
    required String name,
    required String? abbreviation,
    required int color,
  }) async {
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) {
          _budgetRepository.save(
            Budget(
              id: BudgetId.auto(),
              name: name,
              abbreviation: abbreviation,
              color: color,
              budgetUserId: BudgetUserId(user.id.value),
            ),
          );
        },
      ),
    );
  }
}
