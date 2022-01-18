part of 'settings_cubit.dart';

class SettingsState {
  List<Account> accounts;
  List<Category> categories;
  List<SubCategory> subCategories;
  List<Budget> budgets;

  SettingsState({
    required this.accounts,
    required this.categories,
    required this.subCategories,
    required this.budgets,
  });

  factory SettingsState.initial() => SettingsState(
        accounts: Account.defaultAccounts,
        categories: Category.defaultCategories,
        subCategories: SubCategory.allSubCategories,
        budgets: Budget.defaultBudgets,
      );

  SettingsState copyWith({
    List<Account>? accounts,
    List<Category>? categories,
    List<SubCategory>? subCategories,
    List<Budget>? budgets,
  }) {
    return SettingsState(
      accounts: accounts ?? this.accounts,
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      budgets: budgets ?? this.budgets,
    );
  }
}
