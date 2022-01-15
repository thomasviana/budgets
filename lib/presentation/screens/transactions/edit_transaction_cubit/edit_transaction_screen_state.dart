part of 'edit_transaction_screen_cubit.dart';

class EditTransactionScreenState {
  final Transaction? transaction;
  final Account? account;
  final List<Account>? accounts;
  final Category? category;
  final List<Category>? categories;
  final SubCategory? subCategory;
  final List<SubCategory>? subCategories;
  final Budget? budget;
  final UserEntity? user;
  final bool isLoading;
  final bool isEditMode;

  EditTransactionScreenState({
    this.transaction,
    this.account,
    this.accounts,
    this.category,
    this.categories,
    this.subCategory,
    this.subCategories,
    this.budget,
    this.user,
    required this.isLoading,
    required this.isEditMode,
  });

  factory EditTransactionScreenState.initial() => EditTransactionScreenState(
        isLoading: false,
        isEditMode: true,
        account: Account.bank(),
        budget: Budget.seg(),
        category: Category.housing(),
        subCategories: SubCategory.financialSubCategories,
      );

  EditTransactionScreenState copyWith({
    Transaction? transaction,
    Account? account,
    List<Account>? accounts,
    Category? category,
    List<Category>? categories,
    SubCategory? subCategory,
    List<SubCategory>? subCategories,
    Budget? budget,
    UserEntity? user,
    bool? isLoading,
    bool? isEditMode,
  }) {
    return EditTransactionScreenState(
      transaction: transaction ?? this.transaction,
      account: account ?? this.account,
      accounts: accounts ?? this.accounts,
      category: category ?? this.category,
      categories: categories ?? this.categories,
      subCategory: subCategory ?? this.subCategory,
      subCategories: subCategories ?? this.subCategories,
      budget: budget ?? this.budget,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
