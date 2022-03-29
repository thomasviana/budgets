import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
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
  SetDefaultAccounts setDefaultAccounts;
  GetCategories getCategories;
  SetDefaultCategories setDefaultCategories;
  ResetCategories resetCategories;
  GetBudgets getBudgets;
  SetDefaultBudgets setDefaultBudgets;
  SetDefaultSubCategories setDefaultSubCategories;

  SettingsBloc(
    this.getAccounts,
    this.setDefaultAccounts,
    this.getCategories,
    this.setDefaultCategories,
    this.resetCategories,
    this.getBudgets,
    this.setDefaultBudgets,
    this.setDefaultSubCategories,
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
  ) =>
      resetCategories();
}
