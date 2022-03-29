import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/domain.dart';
import '../../../common/extensions.dart';
import '../../../core/accounts/application.dart';
import '../../../core/accounts/domain.dart';
import '../../../core/budgets/application.dart';
import '../../../core/budgets/domain.dart';
import '../../../core/categories/application.dart';
import '../../../core/categories/domain.dart';
import '../../../core/transactions/application.dart';
import '../../utils/observer.dart';
import '../settings/settings_bloc.dart';

part 'stats_event.dart';
part 'stats_state.dart';

@injectable
class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetBudgets _getBudgets;
  final GetCategories _getCategories;
  final GetAccounts _getAccounts;
  final GetTransactions _getTransactions;

  StatsBloc(
    this._getBudgets,
    this._getCategories,
    this._getAccounts,
    this._getTransactions,
  ) : super(StatsState.initial()) {
    on<BudgetsSuscriptionRequested>(
      _onBudgetsSuscriptionRequested,
    );
    on<CategoriesSuscriptionRequested>(
      _onCategoriesSuscriptionRequested,
    );
    on<AccountsSuscriptionRequested>(
      _onAccountsSuscriptionRequested,
    );
    on<TransactionsSuscriptionRequested>(
      _onTransactionsSuscriptionRequested,
    );
    on<StatsDateUpdated>(_onStatsDateUpdated);
  }

  // Future<void> _onUpdateSettings(
  //   UpdateSettings event,
  //   Emitter<StatsState> emit,
  // ) async {
  //   print(event.settings.accounts[0].name);
  //   emit(
  //     state.copyWith(
  //       accounts: event.settings.accounts,
  //       categories: event.settings.categories,
  //       budgets: event.settings.budgets,
  //       status: Status.success,
  //     ),
  //   );
  //   print(event.settings.accounts[0].name);
  // }

  Future<void> _onBudgetsSuscriptionRequested(
    BudgetsSuscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    await emit.onEach<Option<List<Budget>>>(
      _getBudgets(),
      onData: (optionBudgets) => optionBudgets.fold(
        () => emit(
          state.copyWith(
            budgets: [],
            status: Status.failure,
          ),
        ),
        (budgets) {
          emit(
            state.copyWith(
              budgets: budgets,
              status: Status.success,
            ),
          );
        },
      ),
    );
  }

  Future<void> _onCategoriesSuscriptionRequested(
    CategoriesSuscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    await emit.onEach<Option<List<Category>>>(
      _getCategories(),
      onData: (optionCategories) => optionCategories.fold(
        () => emit(
          state.copyWith(
            categories: [],
            status: Status.failure,
          ),
        ),
        (categories) {
          emit(
            state.copyWith(
              categories: categories,
              status: Status.success,
            ),
          );
        },
      ),
    );
  }

  Future<void> _onAccountsSuscriptionRequested(
    AccountsSuscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    await emit.onEach<Option<List<Account>>>(
      _getAccounts(),
      onData: (optionAccounts) => optionAccounts.fold(
        () => emit(
          state.copyWith(
            accounts: [],
            status: Status.failure,
          ),
        ),
        (accounts) {
          emit(
            state.copyWith(
              accounts: accounts,
              status: Status.success,
            ),
          );
        },
      ),
    );
  }

  Future<void> _onTransactionsSuscriptionRequested(
    TransactionsSuscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    await emit.onEach<Option<List<Transaction>>>(
      _getTransactions(),
      onData: (optionTransactions) => optionTransactions.fold(
        () => emit(
          state.copyWith(
            transactions: [],
            status: Status.failure,
          ),
        ),
        (transactions) => emit(
          state.copyWith(
            transactions: transactions,
            status: Status.success,
          ),
        ),
      ),
    );
  }

  Future<void> _onStatsDateUpdated(
    StatsDateUpdated event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(date: event.date, status: Status.success));
  }

  // @override
  // Future<void> close() {
  //   _settingsBlocSuscription?.cancel();
  //   return super.close();
  // }
}
