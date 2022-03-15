import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
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
    final user = await _getProfileInfo().first;
    if (user != null) {
      _budgetRepository.save(
        Budget(
          id: BudgetId.auto(),
          name: name,
          abbreviation: abbreviation,
          color: color,
          budgetUserId: BudgetUserId(user.id.value),
        ),
      );
    }
  }
}
