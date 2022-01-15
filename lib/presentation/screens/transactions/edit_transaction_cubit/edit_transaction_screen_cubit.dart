import 'package:bloc/bloc.dart';
import 'package:budgets/core/accounts/application.dart';
import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/core/budgets/application.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/core/transactions/domain.dart';
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
  GetAccounts getAccounts;
  GetBudgets getBudgets;
  GetCategories getCategories;
  SaveCategories saveCategories;
  GetSubCategories getSubCategories;
  SaveSubCategories saveSubCategories;

  EditTransactionScreenCubit(
    this.updateTransaction,
    this.deleteTransaction,
    this.getProfileInfo,
    this.addTransaction,
    this.getAccounts,
    this.getBudgets,
    this.getCategories,
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
    getUserAccounts();
    getUserCategories();
    getUserSubCategories();
    getUserBudgets();
  }

  Future<void> getUserAccounts() async {
    final userAccounts = await getAccounts(AccountUserId(state.user!.id.value));
    userAccounts.fold(
      () {},
      (accounts) {
        final account = accounts.firstWhere(
          (account) =>
              account.id.value == state.transaction!.txAccountId!.value,
        );
        emit(state.copyWith(account: account, accounts: accounts));
      },
    );
  }

  Future<void> getUserCategories() async {
    final userCategories =
        await getCategories(CategoryUserId(state.user!.id.value));
    userCategories.fold(
      () => _setDefaultCategories(),
      (categories) {
        final category = categories.firstWhere(
          (category) =>
              category.id.value == state.transaction!.txCategoryId!.value,
        );
        emit(state.copyWith(category: category, categories: categories));
      },
    );
  }

  Future<void> _setDefaultCategories() async {
    final categories = Category.defaultCategories;
    for (final category in categories) {
      category.setUserId(state.user!.id.value);
    }
    await saveCategories(categories: categories);
  }

  Future<void> getUserSubCategories() async {
    emit(state.copyWith(isLoading: true));
    if (state.category!.id.value == 'housing' ||
        state.category!.id.value == 'food' ||
        state.category!.id.value == 'transportation' ||
        state.category!.id.value == 'healthCare' ||
        state.category!.id.value == 'services' ||
        state.category!.id.value == 'recreation' ||
        state.category!.id.value == 'shopping' ||
        state.category!.id.value == 'financial') {
      final userSubCategories = await getSubCategories(state.category!.id);
      userSubCategories.fold(
        () => _setDefaultSubCategories(),
        (subCategories) {
          emit(state.copyWith(subCategories: subCategories, isLoading: false));
        },
      );
    } else {
      final userSubCategories = await getSubCategories(state.category!.id);
      userSubCategories.fold(
        () => emit(state.copyWith(subCategories: [])),
        (subCategories) {
          emit(state.copyWith(subCategories: subCategories, isLoading: false));
        },
      );
    }
  }

  Future<void> _setDefaultSubCategories() async {
    final subCategories = SubCategory.allSubCategories;
    await saveSubCategories(subCategories: subCategories);
  }

  Future<void> getUserBudgets() async {
    final userBudgets = await getBudgets(BudgetUserId(state.user!.id.value));
    userBudgets.fold(
      () {},
      (budgets) {
        final budget = budgets.firstWhere(
          (budget) =>
              budget.id.value ==
              (state.transaction! as Expense).txBudgetId!.value,
        );
        emit(state.copyWith(budget: budget));
      },
    );
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
    emit(state.copyWith(account: account));
  }

  void onCategorySelected(Category newCategory) {
    emit(state.copyWith(category: newCategory));
  }

  void onSubCategorySelected(SubCategory subCategory) {
    emit(state.copyWith(subCategory: subCategory));
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
