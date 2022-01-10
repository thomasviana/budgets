import 'package:bloc/bloc.dart';
import 'package:budgets/core/budgets/application.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:budgets/core/user/domain.dart';
import 'package:injectable/injectable.dart';

part 'edit_budget_screen_state.dart';

@injectable
class EditBudgetScreenCubit extends Cubit<EditBudgetScreenState> {
  UpdateBudget updateBudget;
  DeleteBudget deleteBudget;
  GetProfileInfo getProfileInfo;
  CreateBudget createBudget;

  EditBudgetScreenCubit(
    this.updateBudget,
    this.deleteBudget,
    this.getProfileInfo,
    this.createBudget,
  ) : super(EditBudgetScreenState.initial());

  Future<void> init(Budget? budget) async {
    if (budget != null) {
      emit(state.copyWith(budget: budget));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(
          state.copyWith(
            user: UserEntity.empty(),
          ),
        ),
        (user) => emit(
          state.copyWith(
            user: user,
          ),
        ),
      );
    } else {
      emit(state.copyWith(isEditMode: false, budget: Budget.empty()));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(
          state.copyWith(
            user: UserEntity.empty(),
          ),
        ),
        (user) => emit(
          state.copyWith(
            user: user,
          ),
        ),
      );
    }
  }

  void onNameChanged(String? name) {
    if (state.budget == null) return;
    emit(
      state.copyWith(
        budget: state.budget!..updateName(name!),
      ),
    );
  }

  void onAbbreviationChanged(String? abbreviation) {
    if (state.budget == null) return;
    emit(
      state.copyWith(
        budget: state.budget!..updateAbbreviation(abbreviation),
      ),
    );
  }

  Future<void> onBudgetDeleted() async {
    await deleteBudget(state.budget!.id);
  }

  Future<void> onBudgetSaved({bool isNewBudget = false}) async {
    if (isNewBudget) {
      await createBudget(
        budgetUserId: BudgetUserId(state.user!.id.value),
        name: state.budget!.name,
        color: state.budget!.color,
        abbreviation: state.budget!.abbreviation,
        balance: state.budget!.balance,
      );
    } else {
      await updateBudget(
        userId: BudgetUserId(state.user!.id.value),
        budgetId: state.budget!.id,
        name: state.budget!.name,
        color: state.budget!.color,
        abbreviation: state.budget!.abbreviation,
        balance: state.budget!.balance,
      );
    }
  }

  Future<void> onColorUpdated(int newColor) async {
    emit(
      state.copyWith(
        budget: state.budget!..updateColor(newColor),
      ),
    );
  }

  void onBalanceChanged(double newBalance) {
    if (state.budget == null) return;
    emit(
      state.copyWith(
        budget: state.budget!..updateBalance(newBalance),
      ),
    );
  }
}
