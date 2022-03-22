import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/domain.dart';
import '../../../core/budgets/application.dart';
import '../../../core/budgets/domain.dart';
import '../../../core/transactions/application.dart';
import '../../utils/observer.dart';

part 'stats_event.dart';
part 'stats_state.dart';

@injectable
class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetBudgets _getBudgets;
  final SetDefaultBudgets _setDefaultBudgets;
  final GetCategories _getCategories;
  final SetDefaultCategories _setDefaultCategories;
  final SetDefaultSubCategories _setDefaultSubCategories;
  final GetTransactions _getTransactions;
  StatsBloc(
    this._getBudgets,
    this._setDefaultBudgets,
    this._getCategories,
    this._setDefaultCategories,
    this._setDefaultSubCategories,
    this._getTransactions,
  ) : super(StatsState.initial()) {
    on<GetUserBudgets>(
      _onGetUserBudgets,
      transformer: sequential(),
    );
    on<GetUserCategories>(
      _onGetUserCategories,
      transformer: sequential(),
    );
    on<TransactionsSuscriptionRequested>(
      _onTransactionsSuscriptionRequested,
      transformer: sequential(),
    );
    on<StatsDateUpdated>(_onStatsDateUpdated);
  }

  Future<void> _onGetUserBudgets(
    GetUserBudgets event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    await emit.onEach<Option<List<Budget>>>(
      _getBudgets(),
      onData: (userBudgets) async {
        userBudgets.fold(
          () async => _setDefaultBudgets(),
          (budgets) => emit(
            state.copyWith(
              budgets: budgets,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onGetUserCategories(
    GetUserCategories event,
    Emitter<StatsState> emit,
  ) async {
    await emit.onEach<Option<List<Category>>>(
      _getCategories(),
      onData: (userCategories) async {
        userCategories.fold(
          () async => _setDefaultCategories()
              .then((value) => _setDefaultSubCategories()),
          (categories) => emit(state.copyWith(categories: categories)),
        );
      },
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
    emit(state.copyWith(date: event.date));
  }
}
