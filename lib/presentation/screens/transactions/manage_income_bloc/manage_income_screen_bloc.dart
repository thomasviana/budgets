import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/budgets/application.dart';
import '../../../../core/budgets/domain.dart';
import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';

part 'manage_income_screen_event.dart';
part 'manage_income_screen_state.dart';

@injectable
class ManageIncomeScreenBloc
    extends Bloc<ManageIncomeScreenEvent, ManageIncomeScreenState> {
  UpdateBudget updateBudget;
  UpdateTransaction updateTransaction;
  ManageIncomeScreenBloc(
    this.updateBudget,
    this.updateTransaction,
  ) : super(ManageIncomeScreenState.initial()) {
    on<CheckInitialValues>((event, emit) {
      event.budgets != null
          ? emit(
              state.copyWith(
                transactionId: event.transactionId,
                budgets: event.budgets,
                incomeAmount: event.incomeAmount,
                pendingAmount: event.incomeAmount,
                isLoading: false,
                budgetAmounts: List<double>.filled(
                  event.budgets!.length,
                  0,
                  growable: true,
                ),
                budgetPercentages: List<double>.filled(
                  event.budgets!.length,
                  0,
                  growable: true,
                ),
              ),
            )
          : emit(
              state.copyWith(
                transactionId: event.transactionId,
                budgets: [],
                incomeAmount: 0.0,
                isLoading: false,
              ),
            );
    });

    on<BudgetIncremented>((event, emit) {
      state.budgetPercentages![event.index] += 0.1;
      state.budgetAmounts![event.index] =
          state.incomeAmount! * (state.budgetPercentages![event.index]);
      updateValues(emit);
      emit(
        state.copyWith(
          budgetAmounts: state.budgetAmounts,
          budgetPercentages: state.budgetPercentages,
        ),
      );
    });

    on<BudgetDecremented>((event, emit) {
      state.budgetPercentages![event.index] -= 0.1;
      state.budgetAmounts![event.index] =
          state.incomeAmount! * (state.budgetPercentages![event.index]);
      updateValues(emit);
      emit(
        state.copyWith(
          budgetAmounts: state.budgetAmounts,
          budgetPercentages: state.budgetPercentages,
        ),
      );
    });
  }

  BudgetManagementMap getBudgetsInfo() {
    final budgetsInfo = <String, Map<String, double>>{};
    for (var index = 0; index < state.budgets!.length; index++) {
      budgetsInfo.putIfAbsent(state.budgets![index].id.value, () {
        return {
          'spent': 0.0,
          'budgeted': state.budgetAmounts![index].round().toDouble(),
        };
      });
    }
    return budgetsInfo;
  }

  void updateValues(Emitter emit) {
    double totalManagedAmount = 0;
    for (final amount in state.budgetAmounts!) {
      totalManagedAmount += amount.round();
    }
    emit(
      state.copyWith(
        managedAmount: totalManagedAmount,
        pendingAmount: state.incomeAmount! - totalManagedAmount,
      ),
    );
  }
}
