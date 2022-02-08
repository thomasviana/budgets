part of 'edit_transaction_screen_bloc.dart';

class EditTransactionScreenState {
  final Transaction? transaction;
  final Option<Account> account;
  final Option<Category> category;
  final Option<SubCategory> subCategory;
  final List<SubCategory>? subCategories;
  final Option<Budget> budget;
  final bool isLoading;
  final bool isEditMode;
  final bool managementDone;

  EditTransactionScreenState({
    this.transaction,
    required this.account,
    required this.category,
    required this.subCategory,
    this.subCategories,
    required this.budget,
    required this.isLoading,
    required this.isEditMode,
    this.managementDone = false,
  });

  bool get isSaveEnabled => transaction!.amount != 0 && category.isSome();

  factory EditTransactionScreenState.initial() => EditTransactionScreenState(
        isLoading: true,
        isEditMode: false,
        account: none(),
        budget: none(),
        category: none(),
        subCategory: none(),
      );

  EditTransactionScreenState copyWith({
    Transaction? transaction,
    Option<Account>? account,
    Option<Category>? category,
    Option<SubCategory>? subCategory,
    List<SubCategory>? subCategories,
    Option<Budget>? budget,
    bool? isLoading,
    bool? isEditMode,
    bool? managementDone,
  }) {
    return EditTransactionScreenState(
      transaction: transaction ?? this.transaction,
      account: account ?? this.account,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      subCategories: subCategories ?? this.subCategories,
      budget: budget ?? this.budget,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
      managementDone: managementDone ?? this.managementDone,
    );
  }
}
