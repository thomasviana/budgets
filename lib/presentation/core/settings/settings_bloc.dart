import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/accounts/application.dart';
import '../../../core/accounts/domain.dart';
import '../../../core/budgets/application.dart';
import '../../../core/budgets/domain.dart';
import '../../../core/categories/application.dart';
import '../../../core/categories/domain.dart';
import '../../../core/user/application.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  GetProfileInfo getProfileInfo;
  GetAccounts getAccounts;
  SetDefaultAccounts setDefaultAccounts;
  GetCategories getCategories;
  SetDefaultCategories setDefaultCategories;
  GetBudgets getBudgets;
  SetDefaultBudgets setDefaultBudgets;
  SetDefaultSubCategories setDefaultSubCategories;

  SettingsBloc(
    this.getProfileInfo,
    this.getAccounts,
    this.setDefaultAccounts,
    this.getCategories,
    this.setDefaultCategories,
    this.getBudgets,
    this.setDefaultBudgets,
    this.setDefaultSubCategories,
  ) : super(SettingsState.initial()) {
    on<GetUserAccounts>(_getUserAccounts);
    on<GetUserCategories>(_getUserCategories);
    on<GetUserBudgets>(_getUserBudgets);
    developer.log('getUserSettings');
  }

  Future<void> _getUserAccounts(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final userOption = await getProfileInfo();
    await emit.onEach<Option<List<Account>>>(
      userOption.fold(
        () => Stream.empty(),
        (user) => getAccounts(AccountUserId(user.id.value)),
      ),
      onData: (userAccounts) async {
        userAccounts.fold(
          () async => setDefaultAccounts(),
          (accounts) => emit(state.copyWith(accounts: accounts)),
        );
      },
    );
  }

  Future<void> _getUserCategories(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final userOption = await getProfileInfo();
    await emit.onEach<Option<List<Category>>>(
      userOption.fold(
        () => Stream.empty(),
        (user) => getCategories(CategoryUserId(user.id.value)),
      ),
      onData: (userCategories) async {
        userCategories.fold(
          () async =>
              setDefaultCategories().then((value) => setDefaultSubCategories()),
          (categories) => emit(state.copyWith(categories: categories)),
        );
      },
    );
  }

  Future<void> _getUserBudgets(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final userOption = await getProfileInfo();
    await emit.onEach<Option<List<Budget>>>(
      userOption.fold(
        () => Stream.empty(),
        (user) => getBudgets(BudgetUserId(user.id.value)),
      ),
      onData: (userBudgets) async {
        userBudgets.fold(
          () async => setDefaultBudgets(),
          (budgets) => emit(state.copyWith(budgets: budgets)),
        );
      },
    );
  }
}
