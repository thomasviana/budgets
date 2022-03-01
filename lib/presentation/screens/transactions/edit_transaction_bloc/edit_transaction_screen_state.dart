part of 'edit_transaction_screen_bloc.dart';

class EditTransactionScreenState {
  final Transaction transaction;
  final Option<Account> account;
  final Option<Category> category;
  final Option<SubCategory> subCategory;
  final List<SubCategory>? subCategories;
  final List<SubCategory>? allSubCategories;
  final List<SubCategory>? subCategorySuggestions;
  final Option<Budget> budget;
  final List<Budget> budgets;
  final bool isLoading;
  final bool isEditMode;
  final String? query;

  EditTransactionScreenState({
    required this.transaction,
    required this.account,
    required this.category,
    required this.subCategory,
    this.subCategories,
    this.allSubCategories,
    this.subCategorySuggestions,
    required this.budget,
    required this.budgets,
    required this.isLoading,
    required this.isEditMode,
    this.query = '',
  });

  bool get isIncomeManaged =>
      transaction.isIncome && transaction.isIncomeManaged;
  bool get isSaveEnabled =>
      transaction.amount != 0 &&
      subCategory.isSome() &&
      (transaction.isIncome
          ? transaction.isIncomeManaged
          : transaction.isExpense);
  bool get isDefaultCategory => category.fold(
        () => false,
        (category) => Category.defaultCategories
            .any((defCategory) => defCategory.id.value == category.id.value),
      );

  factory EditTransactionScreenState.initial() => EditTransactionScreenState(
        transaction: Transaction.empty(),
        isLoading: true,
        isEditMode: false,
        account: none(),
        budget: none(),
        category: none(),
        subCategory: none(),
        subCategorySuggestions: [],
        budgets: [],
      );

  EditTransactionScreenState copyWith({
    Transaction? transaction,
    Option<Account>? account,
    Option<Category>? category,
    Option<SubCategory>? subCategory,
    List<SubCategory>? subCategories,
    List<SubCategory>? allSubCategories,
    List<SubCategory>? subCategorySuggestions,
    Option<Budget>? budget,
    List<Budget>? budgets,
    bool? isLoading,
    bool? isEditMode,
    String? query,
  }) {
    return EditTransactionScreenState(
      transaction: transaction ?? this.transaction,
      account: account ?? this.account,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      subCategories: subCategories ?? this.subCategories,
      allSubCategories: allSubCategories ?? this.allSubCategories,
      subCategorySuggestions:
          subCategorySuggestions ?? this.subCategorySuggestions,
      budget: budget ?? this.budget,
      budgets: budgets ?? this.budgets,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
      query: query ?? this.query,
    );
  }
}
