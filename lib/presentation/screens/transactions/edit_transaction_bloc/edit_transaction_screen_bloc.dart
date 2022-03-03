import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/accounts/domain.dart';
import '../../../../core/budgets/domain.dart';
import '../../../../core/categories/application.dart';
import '../../../../core/categories/domain.dart';
import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../../resources/resources.dart';

part 'edit_transaction_screen_event.dart';
part 'edit_transaction_screen_state.dart';

@injectable
class EditTransactionScreenBloc
    extends Bloc<EditTransactionScreenEvent, EditTransactionScreenState> {
  UpdateTransaction updateTransaction;
  DeleteTransaction deleteTransaction;
  AddTransaction addTransaction;
  GetSubCategories getSubCategories;
  SetDefaultSubCategories setDefaultSubCategories;
  EditTransactionScreenBloc(
    this.updateTransaction,
    this.deleteTransaction,
    this.addTransaction,
    this.getSubCategories,
    this.setDefaultSubCategories,
  ) : super(EditTransactionScreenState.initial()) {
    on<CheckTransaction>((event, emit) {
      if (event.transaction != null) {
        final account = event.accounts.firstWhere(
          (account) =>
              account.id.value == event.transaction!.txAccountId!.value,
        );
        final subCategory = event.subCategories.firstWhere(
          (subCategory) =>
              subCategory.id.value == event.transaction!.txSubCategoryId!.value,
        );
        final budget = event.budgets.lastWhere(
          (budget) => budget.id.value == event.transaction!.txBudgetId!.value,
        );
        emit(
          state.copyWith(
            transaction: event.transaction,
            isEditMode: true,
            isLoading: false,
            account: some(account),
            subCategory: some(subCategory),
            budget: some(budget),
            budgets: event.budgets,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            account: optionOf(event.accounts.first),
            budget: optionOf(
              event.budgets.firstWhere((account) => account.id.value == 'seg'),
            ),
            budgets: event.budgets,
          ),
        );
      }
    });

    on<GetUserSubcategories>((event, emit) async {
      await emit.onEach<Option<List<SubCategory>>>(
        state.category.fold(
          () => Stream.empty(),
          (category) => getSubCategories(category.id),
        ),
        onData: (optionSubCategories) => optionSubCategories.fold(
          () {},
          (subCategories) => emit(state.copyWith(subCategories: subCategories)),
        ),
      );
    });

    // For search subcategories feature
    on<GetAllUserSubcategories>((event, emit) async {
      await emit.onEach<Option<List<SubCategory>>>(
        getSubCategories.all(),
        onData: (optionSubCategories) => optionSubCategories.fold(
          () => emit(state.copyWith(allSubCategories: [])),
          (allSubCategories) =>
              emit(state.copyWith(allSubCategories: allSubCategories)),
        ),
      );
    });

    on<SearchSubCategory>((event, emit) {
      final suggestions = state.allSubCategories!.where((subCategory) {
        final nameLower = subCategory.name.toLowerCase();
        final searchLower = event.query.toLowerCase();
        return nameLower.contains(searchLower);
      }).toList();
      emit(
        state.copyWith(query: event.query, subCategorySuggestions: suggestions),
      );
    });

    on<TransactionSaved>(
      (event, emit) async {
        if (state.isEditMode) {
          await updateTransaction(
            transactionId: state.transaction.id,
            title: state.subCategory
                .fold(() => '', (subCategory) => subCategory.name),
            amount: event.amount,
            date: event.date,
            note: state.transaction.note,
            icon: state.subCategory
                .fold(() => 0xe532, (subCategory) => subCategory.icon),
            color: state.subCategory.fold(
              () => AppColors.primaryColor.value,
              (subCategory) => subCategory.color,
            ),
            txAccountId: state.account.fold(
              () => null,
              (account) => TransactionAccountId(account.id.value),
            ),
            txBudgetId: state.budget.fold(
              () => null,
              (budget) => TransactionBudgetId(budget.id.value),
            ),
            txCategoryId: state.category.fold(
              () => null,
              (category) => TransactionCategoryId(category.id.value),
            ),
            txType: state.transaction.transactionType,
            incomeType: state.transaction.incomeType,
            isIncomeManaged: state.transaction.isIncomeManaged,
            budgetManagement: state.transaction.budgetManagement,
          );
        } else {
          await addTransaction(
            title: state.subCategory
                .fold(() => '', (subCategory) => subCategory.name),
            amount: event.amount,
            date: event.date,
            note: state.transaction.note ?? '',
            icon: state.subCategory
                .fold(() => 0xe532, (subCategory) => subCategory.icon),
            color: state.subCategory.fold(
              () => AppColors.primaryColor.value,
              (subCategory) => subCategory.color,
            ),
            txAccountId: state.account.fold(
              () => null,
              (account) => TransactionAccountId(account.id.value),
            ),
            txBudgetId: state.budget.fold(
              () => null,
              (budget) => TransactionBudgetId(budget.id.value),
            ),
            txCategoryId: state.category.fold(
              () => null,
              (category) => TransactionCategoryId(category.id.value),
            ),
            txSubCategoryId: state.subCategory.fold(
              () => null,
              (subCategory) => TransactionSubCategoryId(subCategory.id.value),
            ),
            txType: state.transaction.transactionType,
            incomeType: state.transaction.incomeType,
            isIncomeManaged: state.transaction.isIncomeManaged,
            budgetManagement: state.transaction.isIncome
                ? state.transaction.budgetManagement
                : setBudgetSpent(event.amount),
          );
        }
      },
    );

    on<TransactionTypeChanged>(
      (event, emit) {
        emit(
          state.copyWith(
            transaction: state.transaction.copyWith(
              transactionType: TransactionType.values[event.index!],
            ),
            category: none(),
            subCategory: none(),
          ),
        );
      },
    );
    on<AmountUpdated>(
      (event, emit) => emit(
        state.copyWith(
          transaction: state.transaction.copyWith(amount: event.amount),
        ),
      ),
    );
    on<AccountSelected>(
      (event, emit) => emit(
        state.copyWith(account: some(event.account)),
      ),
    );
    on<CategorySelected>(
      (event, emit) async => getSubCategories(event.category.id).first.then(
            (option) => option.fold(
              () {},
              (subCategories) => emit(
                state.copyWith(
                  subCategories: subCategories,
                  category: some(event.category),
                ),
              ),
            ),
          ),
    );
    on<SubCategorySelected>(
      (event, emit) => emit(
        state.copyWith(subCategory: some(event.subCategory)),
      ),
    );
    on<IncomeTypeChanged>(
      (event, emit) {
        emit(
          state.copyWith(
            transaction: state.transaction.copyWith(
              incomeType: IncomeType.values[event.index!],
            ),
          ),
        );
      },
    );
    on<BudgetSelected>(
      (event, emit) => emit(
        state.copyWith(budget: some(event.budget)),
      ),
    );
    on<IncomeManagementDone>(
      (event, emit) => emit(
        state.copyWith(
          transaction: state.transaction.copyWith(
            isIncomeManaged: true,
            budgetManagement: event.budgetsInfo,
          ),
        ),
      ),
    );
    on<DateUpdated>(
      (event, emit) => emit(
        state.copyWith(
          transaction: state.transaction.copyWith(date: event.date),
        ),
      ),
    );
    on<NoteUpdated>(
      (event, emit) => emit(
        state.copyWith(
          transaction: state.transaction.copyWith(note: event.note),
        ),
      ),
    );
    on<Dispose>(
      (event, emit) => emit(
        EditTransactionScreenState.initial(),
      ),
    );
  }

  BudgetManagementMap setBudgetSpent(double spentAmount) {
    final budgetsInfo = <String, Map<String, double>>{};
    for (var index = 0; index < state.budgets.length; index++) {
      budgetsInfo.putIfAbsent(state.budgets[index].id.value, () {
        return {
          'spent': state.budget.fold(() => false, (budget) => budget) ==
                  state.budgets[index]
              ? spentAmount
              : 0.0,
          'budgeted': 0.0,
        };
      });
    }
    return budgetsInfo;
  }
}
