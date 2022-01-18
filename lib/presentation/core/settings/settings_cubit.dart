import 'package:bloc/bloc.dart';
import 'package:budgets/core/budgets/application.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/core/user/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/accounts/application.dart';
import '../../../../core/accounts/domain.dart';
import '../../../../core/user/application.dart';

part 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  GetProfileInfo getProfileInfo;
  GetAccounts getAccounts;
  SaveAccounts saveAccounts;
  GetCategories getCategories;
  SaveCategories saveCategories;
  GetBudgets getBudgets;
  SaveBudgets saveBudgets;

  SettingsCubit(
    this.getProfileInfo,
    this.getAccounts,
    this.saveAccounts,
    this.getCategories,
    this.saveCategories,
    this.getBudgets,
    this.saveBudgets,
  ) : super(SettingsState.initial());

  Future<void> getSettings() async {
    final userOption = await getProfileInfo();
    userOption.fold(
      () => null,
      (user) async {
        getAccounts(AccountUserId(user.id.value)).then(
          (userAccounts) => userAccounts.fold(
            () => _setDefaultAccounts(user),
            (accounts) => emit(state.copyWith(accounts: accounts)),
          ),
        );
        getCategories(CategoryUserId(user.id.value)).then(
          (userCategories) => userCategories.fold(
            () => _setDefaultCategories(user),
            (categories) => emit(state.copyWith(categories: categories)),
          ),
        );
        getBudgets(BudgetUserId(user.id.value)).then(
          (userBudgets) => userBudgets.fold(
            () => _setDefaultBudgets(user),
            (budgets) => emit(state.copyWith(budgets: budgets)),
          ),
        );
      },
    );
  }

  Future<void> _setDefaultAccounts(UserEntity user) async {
    final accounts = Account.defaultAccounts;
    for (final account in accounts) {
      account.setUserId(user.id.value);
    }
    await saveAccounts(accounts: accounts);
  }

  Future<void> _setDefaultCategories(UserEntity user) async {
    final categories = Category.defaultCategories;
    for (final category in categories) {
      category.setUserId(user.id.value);
    }
    await saveCategories(categories: categories);
  }

  Future<void> _setDefaultBudgets(UserEntity user) async {
    final budgets = Budget.defaultBudgets;
    for (final budget in budgets) {
      budget.setUserId(user.id.value);
    }
    await saveBudgets(budgets: budgets);
  }
}
