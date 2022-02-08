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
  SaveCategories saveCategories;
  GetSubCategories getSubCategories;
  SaveSubCategories saveSubCategories;
  EditTransactionScreenBloc(
    this.updateTransaction,
    this.deleteTransaction,
    this.getProfileInfo,
    this.addTransaction,
    this.saveCategories,
    this.getSubCategories,
    this.saveSubCategories,
  ) : super(EditTransactionScreenState.initial()) {
    on<CheckTransaction>((event, emit) {
      event.transaction != null
          ? emit(state.copyWith(
              transaction: event.transaction,
              isEditMode: true,
              isLoading: false,
            ))
          : emit(state.copyWith(
              transaction: Transaction.empty(),
              isEditMode: false,
              isLoading: false,
            ));
    });
    on<GetUserSubcategories>((event, emit) async {
      state.category.fold(
        () {},
        (stateCategory) async {
          final isDefaultCategory = Category.defaultCategories.any((category) =>
              category.id.value == stateCategory.id.value &&
              category.type == CategoryType.expense);
          await emit.onEach<Option<List<SubCategory>>>(
            getSubCategories(stateCategory.id),
            onData: (optionSubCategories) => optionSubCategories.fold(
              () => isDefaultCategory
                  ? _setDefaultSubCategories(emit)
                  : emit(state.copyWith(subCategories: [])),
              (subCategories) =>
                  emit(state.copyWith(subCategories: subCategories)),
            ),
          );
        },
      );
    });
    on<TransactionDeleted>(
      (event, emit) async => deleteTransaction(state.transaction!.id),
    );
    on<TransactionSaved>(
      (event, emit) async => getProfileInfo().then(
        (optionUser) => optionUser.fold(
          () => null,
          (user) async {
            if (state.isEditMode) {
              await updateTransaction(
                transactionId: state.transaction!.id,
                amount: event.amount,
                date: event.date,
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
                amount: event.amount,
                date: event.date,
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
      ),
    );
    on<TransactionTypeChanged>(
      (event, emit) => emit(
        state.copyWith(
          transaction: state.transaction!.copyWith(
            transactionType: TransactionType.values[event.index!],
          ),
          category: none(),
          subCategory: none(),
        ),
      ),
    );
    on<AmountUpdated>(
      (event, emit) => emit(
        state.copyWith(
            transaction: state.transaction!.copyWith(amount: event.amount)),
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
    on<BudgetSelected>(
      (event, emit) => emit(
        state.copyWith(budget: some(event.budget)),
      ),
    );
    on<IncomeManagementDone>(
      (event, emit) => emit(state.copyWith(managementDone: true)),
    );
    on<DateUpdated>(
      (event, emit) => emit(
        state.copyWith(
            transaction: state.transaction!.copyWith(date: event.date)),
      ),
    );
    on<NoteUpdated>(
      (event, emit) => emit(
        state.copyWith(
            transaction: state.transaction!.copyWith(note: event.note)),
      ),
    );
  }
  Future<void> _setDefaultSubCategories(Emitter emit) async {
    final subCategories = SubCategory.allSubCategories;
    await saveSubCategories(subCategories: subCategories);
    emit(state.copyWith(subCategories: subCategories));
  }
}
