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
      final bool isManagedAlready =
          event.transaction.budgetManagement!.isNotEmpty;
      event.budgets != null
          ? emit(
              state.copyWith(
                transactionId: event.transaction.id,
                budgets: event.budgets,
                incomeAmount: event.transaction.amount,
                pendingAmount:
                    isManagedAlready ? 0.0 : event.transaction.amount,
                isLoading: false,
                budgetAmounts: isManagedAlready
                    ? event.transaction.budgetManagement!.values.toList()
                    : List<double>.filled(
                        event.budgets!.length,
                        0,
                        growable: true,
                      ),
                budgetPercentages: isManagedAlready
                    ? event.transaction.budgetManagement!.values
                        .map((value) => value / event.transaction.amount)
                        .toList()
                    : List<double>.filled(
                        event.budgets!.length,
                        0,
                        growable: true,
                      ),
              ),
            )
          : emit(
              state.copyWith(
                transactionId: event.transaction.id,
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
    final budgetsInfo = <String, double>{};
    for (var index = 0; index < state.budgets!.length; index++) {
      budgetsInfo.putIfAbsent(state.budgets![index].id.value, () {
        return state.budgetAmounts![index].round().toDouble();
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
