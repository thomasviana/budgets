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
          ? emit(state.copyWith(
              budgets: event.budgets,
              incomeAmount: event.incomeAmount,
              pendingAmount: event.incomeAmount,
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
      updateValues();
      emit(state.copyWith(
        budgetAmounts: state.budgetAmounts,
        budgetPercentages: state.budgetPercentages,
      ));
    });

    on<BudgetDecremented>((event, emit) {
      state.budgetPercentages![event.index] -= 0.1;
      state.budgetAmounts![event.index] =
          state.incomeAmount! * (state.budgetPercentages![event.index]);
      updateValues();
      emit(state.copyWith(
        budgetAmounts: state.budgetAmounts,
        budgetPercentages: state.budgetPercentages,
      ));
    });

    on<IncomeManaged>(
      (event, emit) async => getProfileInfo().then(
        (userOption) => userOption.fold(
          () {},
          (user) async {
            for (var index = 0; index < state.budgets!.length; index++) {
              await updateBudget(
                userId: BudgetUserId(user.id.value),
                budgetId: state.budgets![index].id,
                balance: state.budgetAmounts![index],
              );
            }
          },
        ),
      ),
    );
  }

  void updateValues() {
    double totalManagedAmount = 0;
    for (final amount in state.budgetAmounts!) {
      totalManagedAmount += amount;
    }
    state.managedAmount = totalManagedAmount;
    state.pendingAmount = state.incomeAmount! - state.managedAmount;
  }
}
