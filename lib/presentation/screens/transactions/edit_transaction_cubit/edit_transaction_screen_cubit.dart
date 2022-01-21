// ignore_for_file: require_trailing_commas

import 'package:bloc/bloc.dart';
import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../../../core/user/application.dart';

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

  void init(Transaction? transaction) {
    transaction != null
        ? emit(state.copyWith(transaction: transaction, isEditMode: true))
        : emit(state.copyWith(
            transaction: Transaction.empty(), isEditMode: false));
  }

  Future<void> getUserSubCategories() async {
    state.category.fold(
      () => null,
      (stateCategory) {
        final isDefaultCategory = Category.defaultCategories
            .any((category) => category.id.value == stateCategory.id.value);
        getSubCategories(stateCategory.id).then(
          (optionSubCategories) => optionSubCategories.fold(
            () => isDefaultCategory
                ? _setDefaultSubCategories()
                : emit(state.copyWith(subCategories: [])),
            (subCategories) =>
                emit(state.copyWith(subCategories: subCategories)),
          ),
        );
      },
    );
  }

  Future<void> _setDefaultSubCategories() async {
    final subCategories = SubCategory.allSubCategories;
    await saveSubCategories(subCategories: subCategories);
    emit(state.copyWith(subCategories: subCategories));
  }

  Future<void> onTransactionDeleted() async {
    await deleteTransaction(state.transaction!.id);
  }

  Future<void> onTransactionSaved(double amount, DateTime date) async {
    getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () => null,
        (user) async {
          if (state.isEditMode) {
            await updateTransaction(
              transactionId: state.transaction!.id,
              amount: amount,
              date: date,
              note: state.transaction!.note,
              txAccountId: state.account.fold(
                () {},
                (account) => TransactionAccountId(account.id.value),
              ),
              txBudgetId: state.budget.fold(
                () {},
                (budget) => TransactionBudgetId(budget.id.value),
              ),
              txCategoryId: state.category.fold(
                () {},
                (category) => TransactionCategoryId(category.id.value),
              ),
              txUserId: TransactionUserId(user.id.value),
              incomeType: IncomeType.values[1],
            );
          } else {
            await addTransaction(
              title: state.subCategory
                  .fold(() => '', (subCategory) => subCategory.name),
              amount: amount,
              date: date,
              note: state.transaction!.note,
              icon: state.subCategory
                  .fold(() => 0xe532, (subCategory) => subCategory.icon),
              color: state.subCategory.fold(
                () => AppColors.primaryColor.value,
                (subCategory) => subCategory.color,
              ),
              txAccountId: state.account.fold(
                () => TransactionAccountId('bank'),
                (account) => TransactionAccountId(account.id.value),
              ),
              txBudgetId: state.budget.fold(
                () => TransactionBudgetId('seg'),
                (budget) => TransactionBudgetId(budget.id.value),
              ),
              txCategoryId: state.category.fold(
                () => TransactionCategoryId('housing'),
                (category) => TransactionCategoryId(category.id.value),
              ),
              txType: TransactionType.values[1],
              txUserId: TransactionUserId(user.id.value),
              incomeType: IncomeType.values[1],
            );
          }
        },
      ),
    );
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
      state.copyWith(transaction: state.transaction!..updateAmount(newAmount)),
    );
  }

  void onAccountSelected(Account account) {
    emit(state.copyWith(account: some(account)));
  }

  Future<void> onCategorySelected(Category category) async {
    await getSubCategories(category.id).then((option) => option.fold(
        () {},
        (subCategories) => emit(state.copyWith(
            subCategories: subCategories, category: some(category)))));
  }

  void onSubCategorySelected(SubCategory subCategory) {
    emit(state.copyWith(subCategory: some(subCategory)));
  }

  void onBudgetSelected(Budget budget) {
    emit(state.copyWith(budget: some(budget)));
  }

  void onDateUpdated(DateTime? newDate) {
    emit(state.copyWith(transaction: state.transaction!..updateDate(newDate!)));
  }

  void onNoteUpdated(String? newNote) {
    emit(state.copyWith(transaction: state.transaction!..updateNote(newNote!)));
  }
}
