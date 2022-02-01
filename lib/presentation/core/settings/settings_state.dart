part of 'settings_bloc.dart';

class SettingsState {
  List<Account> accounts;
  List<Category> categories;
  List<SubCategory> subCategories;
  List<Budget> budgets;
  bool done;

  SettingsState({
    required this.accounts,
    required this.categories,
    required this.subCategories,
    required this.budgets,
    required this.done,
  });

  factory SettingsState.initial() => SettingsState(
        accounts: Account.defaultAccounts,
        categories: Category.defaultCategories,
        subCategories: SubCategory.allSubCategories,
        budgets: Budget.defaultBudgets,
        done: false,
      );

  SettingsState copyWith({
    List<Account>? accounts,
    List<Category>? categories,
    List<SubCategory>? subCategories,
    List<Budget>? budgets,
    bool? done,
  }) {
    return SettingsState(
      accounts: accounts ?? this.accounts,
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      budgets: budgets ?? this.budgets,
      done: done ?? this.done,
    );
  }
}
