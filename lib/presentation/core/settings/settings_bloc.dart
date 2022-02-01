import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:budgets/core/accounts/application.dart';
import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/core/budgets/application.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/core/user/application.dart';
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
    on<GetUserAccounts>(_getUserAccounts, transformer: concurrent());
    on<GetUserCategories>(_getUserCategories, transformer: concurrent());
    on<GetUserBudgets>(_getUserBudgets, transformer: concurrent());
    developer.log('getUserSettings');
  }

  Future<void> _getUserAccounts(
      SettingsEvent event, Emitter<SettingsState> emit) async {
    final userOption = await getProfileInfo();
    await emit.onEach<Option<List<Account>>>(
      userOption.fold(
        () => Stream.empty(),
        (user) => getAccounts(AccountUserId(user.id.value)),
      ),
      onData: (userAccounts) async {
        userAccounts.fold(
          () async => _setDefaultAccounts(),
          (accounts) => emit(state.copyWith(accounts: accounts)),
        );
      },
    );
  }

  Future<void> _getUserCategories(
      SettingsEvent event, Emitter<SettingsState> emit) async {
    final userOption = await getProfileInfo();
    await emit.onEach<Option<List<Category>>>(
      userOption.fold(
        () => Stream.empty(),
        (user) => getCategories(CategoryUserId(user.id.value)),
      ),
      onData: (userCategories) async {
        userCategories.fold(
          () async => _setDefaultCategories(),
          (categories) => emit(state.copyWith(categories: categories)),
        );
      },
    );
  }

  Future<void> _getUserBudgets(
      SettingsEvent event, Emitter<SettingsState> emit) async {
    final userOption = await getProfileInfo();
    await emit.onEach<Option<List<Budget>>>(
      userOption.fold(() => Stream.empty(),
          (user) => getBudgets(BudgetUserId(user.id.value))),
      onData: (userBudgets) async {
        userBudgets.fold(
          () async => _setDefaultBudgets(),
          (budgets) => emit(state.copyWith(budgets: budgets)),
        );
      },
    );
  }

  Future<void> _setDefaultAccounts() async {
    developer.debugger();
    final userOption = await getProfileInfo();
    userOption.fold(() => null, (user) async {
      final accounts = Account.defaultAccounts;
      for (final account in accounts) {
        account.setUserId(user.id.value);
      }
      await saveAccounts(accounts: accounts);
    });
  }

  Future<void> _setDefaultCategories() async {
    final userOption = await getProfileInfo();
    userOption.fold(() => null, (user) async {
      final categories = Category.defaultCategories;
      final subCategories = SubCategory.allSubCategories;
      for (final category in categories) {
        category.setUserId(user.id.value);
      }
      await saveCategories(categories: categories);
      await saveSubCategories(subCategories: subCategories);
    });
  }

  Future<void> _setDefaultBudgets() async {
    final userOption = await getProfileInfo();
    userOption.fold(() => null, (user) async {
      final budgets = Budget.defaultBudgets;
      for (final budget in budgets) {
        budget.setUserId(user.id.value);
      }
      await saveBudgets(budgets: budgets);
    });
  }
}
