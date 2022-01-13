import 'package:bloc/bloc.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

part 'edit_transaction_bottomsheet_state.dart';

@injectable
class EditTransactionBottomSheetCubit
    extends Cubit<EditTransactionBottomSheetState> {
  UpdateTransaction updateTransaction;
  DeleteTransaction deleteTransaction;
  GetProfileInfo getProfileInfo;
  AddTransaction addTransaction;

  EditTransactionBottomSheetCubit(
    this.updateTransaction,
    this.deleteTransaction,
    this.getProfileInfo,
    this.addTransaction,
  ) : super(EditTransactionBottomSheetState.initial());

  Future<void> init(Transaction? transaction) async {
    if (transaction != null) {
      emit(state.copyWith(transaction: transaction));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(state.copyWith(user: UserEntity.empty())),
        (user) => emit(state.copyWith(user: user)),
      );
    } else {
      emit(state.copyWith(isEditMode: false, transaction: Expense.empty()));
      final userOption = await getProfileInfo();
      userOption.fold(
        () => emit(state.copyWith(user: UserEntity.empty())),
        (user) => emit(state.copyWith(user: user)),
      );
    }
  }

  Future<void> onTransactionDeleted() async {
    await deleteTransaction(state.transaction!.id);
  }

  Future<void> onTransactionSaved({bool isNewTransaction = false}) async {
    if (isNewTransaction) {
      await addTransaction(
        amount: state.transaction!.amount,
        date: state.transaction!.date,
        note: state.transaction!.note,
        txAccountId: state.transaction!.txAccountId!,
        txBudgetId: (state.transaction! as Expense).txBudgetId!,
        txCategoryId: state.transaction!.txCategoryId!,
        txType: TransactionType.values[1],
        txUserId: TransactionUserId(state.user!.id.value),
        incomeType: IncomeType.values[1],
      );
    } else {
      await updateTransaction(
        transactionId: state.transaction!.id,
        amount: state.transaction!.amount,
        date: state.transaction!.date,
        note: state.transaction!.note,
        txAccountId: state.transaction!.txAccountId!,
        txBudgetId: (state.transaction! as Expense).txBudgetId!,
        txCategoryId: state.transaction!.txCategoryId!,
        userId: TransactionUserId(state.user!.id.value),
        incomeType: IncomeType.values[1],
      );
    }
  }

  Future<void> onAmountUpdated(double newAmount) async {
    emit(
      state.copyWith(
        transaction: state.transaction!..updateAmount(newAmount),
      ),
    );
  }

  void onDateUpdated(DateTime? newDate) {
    emit(
      state.copyWith(
        transaction: state.transaction!..updateDate(newDate!),
      ),
    );
  }

  void onNoteUpdated(String? newNote) {
    emit(
      state.copyWith(
        transaction: state.transaction!..updateNote(newNote!),
      ),
    );
  }
}
