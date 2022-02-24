import 'package:bloc/bloc.dart';
import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/core/categories/application.dart';
import 'package:budgets/core/categories/domain.dart';
import 'package:budgets/core/transactions/application.dart';
import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/core/user/application.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

part 'edit_transaction_screen_event.dart';
part 'edit_transaction_screen_state.dart';

@injectable
class EditTransactionScreenBloc
    extends Bloc<EditTransactionScreenEvent, EditTransactionScreenState> {
  UpdateTransaction updateTransaction;
  DeleteTransaction deleteTransaction;
  GetProfileInfo getProfileInfo;
  AddTransaction addTransaction;
  GetSubCategories getSubCategories;
  SetDefaultSubCategories setDefaultSubCategories;
  EditTransactionScreenBloc(
    this.updateTransaction,
    this.deleteTransaction,
    this.getProfileInfo,
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
            account: optionOf(account),
            subCategory: optionOf(subCategory),
            budget: optionOf(budget),
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
      (event, emit) async => getProfileInfo().then(
        (optionUser) => optionUser.fold(
          () => null,
          (user) async {
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
                txType: state.transaction.transactionType,
                txUserId: TransactionUserId(user.id.value),
                incomeType: state.transaction.incomeType,
                isIncomeManaged: state.transaction.isIncomeManaged,
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
                txSubCategoryId: state.subCategory.fold(
                  () {},
                  (subCategory) =>
                      TransactionSubCategoryId(subCategory.id.value),
                ),
                txType: state.transaction.transactionType,
                txUserId: TransactionUserId(user.id.value),
                incomeType: state.transaction.incomeType,
                isIncomeManaged: state.transaction.isIncomeManaged,
              );
            }
          },
        ),
      ),
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
}
