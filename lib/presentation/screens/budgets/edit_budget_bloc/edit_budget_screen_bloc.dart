import 'package:bloc/bloc.dart';
import 'package:budgets/core/budgets/application.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:injectable/injectable.dart';

part 'edit_budget_screen_event.dart';
part 'edit_budget_screen_state.dart';

@injectable
class EditBudgetScreenBloc
    extends Bloc<EditBudgetScreenEvent, EditBudgetScreenState> {
  UpdateBudget updateBudget;
  DeleteBudget deleteBudget;
  CreateBudget createBudget;
  EditBudgetScreenBloc(
    this.updateBudget,
    this.deleteBudget,
    this.createBudget,
  ) : super(EditBudgetScreenState.initial()) {
    on<CheckBudget>((event, emit) {
      event.budget != null
          ? emit(
              state.copyWith(
                budget: event.budget,
                isEditMode: true,
                isLoading: false,
              ),
            )
          : emit(
              state.copyWith(
                budget: Budget.empty(),
                isEditMode: false,
                isLoading: false,
              ),
            );
    });
    on<BudgetDeleted>(
      (event, emit) async => deleteBudget(state.budget!.id),
    );
    on<BudgetSaved>((event, emit) async {
      if (!state.isEditMode) {
        await createBudget(
          name: state.budget!.name,
          color: state.budget!.color,
          abbreviation: state.budget!.abbreviation,
        );
      } else {
        await updateBudget(
          budgetId: state.budget!.id,
          name: state.budget!.name,
          color: state.budget!.color,
          abbreviation: state.budget!.abbreviation,
        );
      }
    });
    on<ColorUpdated>(
      (event, emit) => emit(
        state.copyWith(budget: state.budget!.copyWith(color: event.color)),
      ),
    );

    on<NameChanged>(
      (event, emit) => emit(
        state.copyWith(budget: state.budget!.copyWith(name: event.name)),
      ),
    );
    on<AbbreviationChanged>(
      (event, emit) => emit(
        state.copyWith(
          budget: state.budget!.copyWith(
            abbreviation: event.abbreviation,
          ),
        ),
      ),
    );
    on<BalanceChanged>(
      (event, emit) => emit(
        state.copyWith(budget: state.budget!.copyWith(balance: event.balance)),
      ),
    );
  }
}
