import 'package:bloc/bloc.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:injectable/injectable.dart';

part 'manage_income_screen_event.dart';
part 'manage_income_screen_state.dart';

@injectable
class ManageIncomeScreenBloc
    extends Bloc<ManageIncomeScreenEvent, ManageIncomeScreenState> {
  ManageIncomeScreenBloc() : super(ManageIncomeScreenState.initial()) {
    on<CheckInitialValues>((event, emit) {
      event.budgets != null
          ? emit(state.copyWith(
              budgets: event.budgets,
              incomeAmount: event.incomeAmount,
              isLoading: false,
            ))
          : emit(state.copyWith(
              budgets: [],
              incomeAmount: 0.0,
              isLoading: false,
            ));
      for (final budget in state.budgets!) {
        state.budgetAmounts!.add(0.0);
        state.budgetPercentages!.add(0.0);
      }
    });

    on<BudgetIncremented>((event, emit) {
      state.budgetPercentages![event.index] += 0.1;
      state.budgetAmounts![event.index] =
          state.incomeAmount! * (state.budgetPercentages![event.index]);
      emit(state.copyWith(
        budgetAmounts: state.budgetAmounts,
        budgetPercentages: state.budgetPercentages,
      ));
    });

    on<BudgetDecremented>((event, emit) {
      state.budgetPercentages![event.index] -= 0.1;
      state.budgetAmounts![event.index] =
          state.incomeAmount! * (state.budgetPercentages![event.index]);
      emit(state.copyWith(
        budgetAmounts: state.budgetAmounts,
        budgetPercentages: state.budgetPercentages,
      ));
    });
  }
}
