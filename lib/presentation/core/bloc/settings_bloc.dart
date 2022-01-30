import 'package:bloc/bloc.dart';
import 'package:budgets/core/accounts/application.dart';
import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/core/budgets/application.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:budgets/core/user/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  GetProfileInfo getProfileInfo;
  GetAccounts getAccounts;
  SaveAccounts saveAccounts;
  GetCategories getCategories;
  SaveCategories saveCategories;
  SaveSubCategories saveSubCategories;
  GetBudgets getBudgets;
  SaveBudgets saveBudgets;

  SettingsBloc(
    this.getProfileInfo,
    this.getAccounts,
    this.saveAccounts,
    this.getCategories,
    this.saveCategories,
    this.saveSubCategories,
    this.getBudgets,
    this.saveBudgets,
  ) : super(SettingsState.initial()) {
    on<SettingsRequested>((event, emit) async {
      final userOption = await getProfileInfo();
      userOption.fold(
        () async => null,
        (user) async {
          await emit.onEach<Option<List<Budget>>>(
            getBudgets(BudgetUserId(user.id.value)),
            onData: (userBudgets) async {
              userBudgets.fold(
                () => _setDefaultBudgets(user, emit),
                (budgets) => emit(state.copyWith(budgets: budgets)),
              );
            },
          );

          await emit.onEach<Option<List<Account>>>(
            getAccounts(AccountUserId(user.id.value)),
            onData: (userAccounts) async {
              userAccounts.fold(
                () => _setDefaultAccounts(user, emit),
                (accounts) => emit(state.copyWith(accounts: accounts)),
              );
            },
          );
          await emit.onEach<Option<List<Category>>>(
            getCategories(CategoryUserId(user.id.value)),
            onData: (userCategories) async {
              userCategories.fold(
                () => _setDefaultCategories(user, emit),
                (categories) => emit(state.copyWith(categories: categories)),
              );
            },
          );
        },
      );
      print('settings');
    });
  }
  Future<void> _setDefaultAccounts(UserEntity user, Emitter emit) async {
    final accounts = Account.defaultAccounts;
    for (final account in accounts) {
      account.setUserId(user.id.value);
    }
    await saveAccounts(accounts: accounts);
    emit(state.copyWith(accounts: accounts));
  }

  Future<void> _setDefaultCategories(UserEntity user, Emitter emit) async {
    final categories = Category.defaultCategories;
    final subCategories = SubCategory.allSubCategories;
    for (final category in categories) {
      category.setUserId(user.id.value);
    }
    await saveCategories(categories: categories);
    await saveSubCategories(subCategories: subCategories);
    emit(state.copyWith(categories: categories, subCategories: subCategories));
  }

  Future<void> _setDefaultBudgets(UserEntity user, Emitter emit) async {
    final budgets = Budget.defaultBudgets;
    for (final budget in budgets) {
      budget.setUserId(user.id.value);
    }
    await saveBudgets(budgets: budgets);
    emit(state.copyWith(budgets: budgets));
  }
}
