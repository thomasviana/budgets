part of 'edit_transaction_screen_cubit.dart';

class EditTransactionScreenState {
  final Transaction? transaction;
  final Option<Account> account;
  final Option<Category> category;
  final Option<SubCategory> subCategory;
  final List<SubCategory>? subCategories;
  final Option<Budget> budget;
  final UserEntity? user;
  final bool isLoading;
  final bool isEditMode;

  EditTransactionScreenState({
    this.transaction,
    required this.account,
    required this.category,
    required this.subCategory,
    this.subCategories,
    required this.budget,
    this.user,
    required this.isLoading,
    required this.isEditMode,
  });

  factory EditTransactionScreenState.initial() => EditTransactionScreenState(
      isLoading: false,
      isEditMode: true,
      account: none(),
      budget: none(),
      category: none(),
      subCategory: none());

  EditTransactionScreenState copyWith({
    Transaction? transaction,
    Option<Account>? account,
    Option<Category>? category,
    Option<SubCategory>? subCategory,
    List<SubCategory>? subCategories,
    Option<Budget>? budget,
    UserEntity? user,
    bool? isLoading,
    bool? isEditMode,
  }) {
    return EditTransactionScreenState(
      transaction: transaction ?? this.transaction,
      account: account ?? this.account,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      subCategories: subCategories ?? this.subCategories,
      budget: budget ?? this.budget,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
