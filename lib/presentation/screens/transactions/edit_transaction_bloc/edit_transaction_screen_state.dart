part of 'edit_transaction_screen_bloc.dart';

class EditTransactionScreenState {
  final Transaction? transaction;
  final Option<Account> account;
  final Option<Category> category;
  final Option<SubCategory> subCategory;
  final List<SubCategory>? subCategories;
  final List<SubCategory>? allSubCategories;
  final List<SubCategory>? subCategorySuggestions;
  final Option<Budget> budget;
  final bool isLoading;
  final bool isEditMode;
  final bool managementDone;
  final String? query;

  EditTransactionScreenState({
    this.transaction,
    required this.account,
    required this.category,
    required this.subCategory,
    this.subCategories,
    this.allSubCategories,
    this.subCategorySuggestions,
    required this.budget,
    required this.isLoading,
    required this.isEditMode,
    this.managementDone = false,
    this.query = '',
  });

  bool get isSaveEnabled => transaction!.amount != 0 && subCategory.isSome();

  factory EditTransactionScreenState.initial() => EditTransactionScreenState(
        isLoading: true,
        isEditMode: false,
        account: none(),
        budget: none(),
        category: none(),
        subCategory: none(),
        subCategorySuggestions: [],
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
    bool? isLoading,
    bool? isEditMode,
    bool? managementDone,
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
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
      managementDone: managementDone ?? this.managementDone,
      query: query ?? this.query,
    );
  }
}
