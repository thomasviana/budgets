import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:budgets/core/budgets/application.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

part 'manage_income_screen_event.dart';
part 'manage_income_screen_state.dart';

@injectable
class ManageIncomeScreenBloc
    extends Bloc<ManageIncomeScreenEvent, ManageIncomeScreenState> {
  GetProfileInfo getProfileInfo;
  UpdateBudget updateBudget;
  ManageIncomeScreenBloc(
    this.getProfileInfo,
    this.updateBudget,
  ) : super(ManageIncomeScreenState.initial()) {
    on<CheckInitialValues>((event, emit) {
      event.budgets != null
          ? emit(
              state.copyWith(
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

    on<IncomeManaged>(
      (event, emit) async {
        for (var index = 0; index < state.budgets!.length; index++) {
          await updateBudget(
            budgetId: state.budgets![index].id,
            amount: state.budgetAmounts![index].round().toDouble(),
          );
        }
      },
    );
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
