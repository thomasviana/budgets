import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:budgets/core/accounts/src/application/reset_accounts.dart';
import 'package:budgets/core/budgets/src/application/reset_budgets.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/accounts/application.dart';
import '../../../core/accounts/domain.dart';
import '../../../core/budgets/application.dart';
import '../../../core/budgets/domain.dart';
import '../../../core/categories/application.dart';
import '../../../core/categories/domain.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  GetAccounts getAccounts;
  GetCategories getCategories;
  GetBudgets getBudgets;
  SetDefaultAccounts setDefaultAccounts;
  SetDefaultCategories setDefaultCategories;
  SetDefaultSubCategories setDefaultSubCategories;
  SetDefaultBudgets setDefaultBudgets;
  ResetAccounts resetAccounts;
  ResetCategories resetCategories;
  ResetBudgets resetBudgets;

  SettingsBloc(
    this.getAccounts,
    this.getCategories,
    this.getBudgets,
    this.setDefaultAccounts,
    this.setDefaultCategories,
    this.setDefaultSubCategories,
    this.setDefaultBudgets,
    this.resetAccounts,
    this.resetCategories,
    this.resetBudgets,
  ) : super(SettingsState.initial()) {
    on<GetUserAccounts>(_getUserAccounts);
    on<GetUserCategories>(_getUserCategories);
    on<GetUserBudgets>(_getUserBudgets);
    on<ResetFromFactoryRequested>(_onResetFromFactoryRequested);
    developer.log('getUserSettings');
  }

  Future<void> _getUserAccounts(
    GetUserAccounts event,
    Emitter<SettingsState> emit,
  ) async {
    await emit.onEach<Option<List<Account>>>(
      getAccounts(),
      onData: (userAccounts) async {
        userAccounts.fold(
          () async => setDefaultAccounts(),
          (accounts) => emit(state.copyWith(accounts: accounts)),
        );
      },
    );
  }

  Future<void> _getUserCategories(
    GetUserCategories event,
    Emitter<SettingsState> emit,
  ) async {
    await emit.onEach<Option<List<Category>>>(
      getCategories(),
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
    GetUserBudgets event,
    Emitter<SettingsState> emit,
  ) async {
    await emit.onEach<Option<List<Budget>>>(
      getBudgets(),
      onData: (userBudgets) async {
        userBudgets.fold(
          () async => setDefaultBudgets(),
          (budgets) => emit(state.copyWith(budgets: budgets)),
        );
      },
    );
  }

  Future<void> _onResetFromFactoryRequested(
    ResetFromFactoryRequested event,
    Emitter<SettingsState> emit,
  ) async {
    await resetCategories();
    await resetBudgets();
    resetAccounts();
  }
}
