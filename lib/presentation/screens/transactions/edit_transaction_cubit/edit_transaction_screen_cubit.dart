import 'package:bloc/bloc.dart';
import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';

part 'edit_transaction_screen_state.dart';

@injectable
class EditTransactionScreenCubit extends Cubit<EditTransactionScreenState> {
  UpdateTransaction updateTransaction;
  DeleteTransaction deleteTransaction;
  GetProfileInfo getProfileInfo;
  AddTransaction addTransaction;
  SaveCategories saveCategories;
  GetSubCategories getSubCategories;
  SaveSubCategories saveSubCategories;

  EditTransactionScreenCubit(
    this.updateTransaction,
    this.deleteTransaction,
    this.getProfileInfo,
    this.addTransaction,
    this.saveCategories,
    this.getSubCategories,
    this.saveSubCategories,
  ) : super(EditTransactionScreenState.initial());

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

  Future<void> getUserSubCategories() async {
    emit(state.copyWith(isLoading: true));
    state.category.fold(() => null, (category) async {
      if (category.id.value == 'housing' ||
          category.id.value == 'food' ||
          category.id.value == 'transportation' ||
          category.id.value == 'healthCare' ||
          category.id.value == 'services' ||
          category.id.value == 'recreation' ||
          category.id.value == 'shopping' ||
          category.id.value == 'financial') {
        final userSubCategories = await getSubCategories(category.id);
        userSubCategories.fold(
          () => _setDefaultSubCategories(),
          (subCategories) {
            emit(
                state.copyWith(subCategories: subCategories, isLoading: false));
          },
        );
      } else {
        final userSubCategories = await getSubCategories(category.id);
        userSubCategories.fold(
          () => emit(state.copyWith(subCategories: [])),
          (subCategories) {
            emit(
                state.copyWith(subCategories: subCategories, isLoading: false));
          },
        );
      }
    });
  }

  Future<void> _setDefaultSubCategories() async {
    final subCategories = SubCategory.allSubCategories;
    await saveSubCategories(subCategories: subCategories);
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

  void onTransactionTypeChanged(int? index) {
    emit(
      state.copyWith(
        transaction: state.transaction!
          ..changeType(TransactionType.values[index!]),
      ),
    );
  }

  Future<void> onAmountUpdated(double newAmount) async {
    emit(
      state.copyWith(
        transaction: state.transaction!..updateAmount(newAmount),
      ),
    );
  }

  void onAccountSelected(Account account) {
    emit(state.copyWith(account: some(account)));
  }

  Future<void> onCategorySelected(Category category) async {
    await getSubCategories(category.id).then(
      (option) => option.fold(
        () {},
        (subCategories) => emit(state.copyWith(subCategories: subCategories)),
      ),
    );
  }

  void onSubCategorySelected(SubCategory subCategory) {
    emit(state.copyWith(subCategory: some(subCategory)));
  }

  void onBudgetSelected(Budget budget) {
    emit(state.copyWith(budget: some(budget)));
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
