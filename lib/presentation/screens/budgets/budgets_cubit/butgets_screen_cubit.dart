import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/budgets/application.dart';
import '../../../../core/budgets/domain.dart';
import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

part 'budgets_screen_state.dart';

@injectable
class BudgetsScreenCubit extends Cubit<BudgetsScreenState> {
  GetBudgets getBudgets;
  GetProfileInfo getProfileInfo;
  SaveBudgets saveBudgets;
  CreateBudget createBudget;

  BudgetsScreenCubit(
    this.getBudgets,
    this.getProfileInfo,
    this.createBudget,
    this.saveBudgets,
  ) : super(BudgetsScreenState.initial());

  Future<void> init() async {
    final userOption = await getProfileInfo();
    userOption.fold(
      () => null,
      (user) => emit(state.copyWith(user: user, isLoading: false)),
    );
    getUserBudgets();
  }

  Future<void> getUserBudgets() async {
    final userBudgets = await getBudgets(BudgetUserId(state.user!.id.value));
    userBudgets.fold(
      () => _setDefaultBudgets(),
      (budgets) => emit(state.copyWith(budgets: budgets)),
    );
  }

  Future<void> _setDefaultBudgets() async {
    final budgets = Budget.defaultBudgets;
    for (final budget in budgets) {
      budget.setUserId(state.user!.id.value);
    }
    await saveBudgets(budgets: budgets);
  }
}
