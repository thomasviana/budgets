part of 'stats_bloc.dart';

class StatsState extends MyState {
  final DateTime date;
  final List<Budget> budgets;
  final List<Category> categories;
  final List<Account> accounts;
  final List<Transaction> transactions;

  StatsState({
    required Status status,
    required this.date,
    required this.budgets,
    required this.categories,
    required this.accounts,
    required this.transactions,
  }) : super(status: status);

  factory StatsState.initial() => StatsState(
        status: Status.initial,
        date: DateTime.now(),
        budgets: [],
        categories: [],
        accounts: [],
        transactions: [],
      );

  List<Transaction> get filteredTransactions {
    final filteredTransactions = transactions
        .where((transaction) => transaction.date.month == date.month)
        .toList();
    return filteredTransactions;
  }

  double get incomes => filteredTransactions
      .where((transaction) => transaction.isIncome)
      .map((income) => income.amount)
      .sum;

  double get expenses => filteredTransactions
      .where((transaction) => transaction.isExpense)
      .map((income) => income.amount)
      .sum;

  double get balance => incomes - expenses;

  double get activeIncomes => filteredTransactions
      .where(
        (transaction) => [
          transaction.isIncome,
          transaction.incomeType == IncomeType.active
        ].flatten(),
      )
      .map((income) => income.amount)
      .sum;

  double get pasiveIncomes => filteredTransactions
      .where(
        (transaction) => [
          transaction.isIncome,
          transaction.incomeType == IncomeType.pasive
        ].flatten(),
      )
      .map((income) => income.amount)
      .sum;

  List<BudgetData> get budgetsData {
    final list = <BudgetData>[];
    for (final budget in budgets) {
      var spent = 0.0;
      var budgeted = 0.0;
      for (final transaction in filteredTransactions) {
        final amount1 = transaction.amount;
        if (transaction.isExpense &&
            transaction.txBudgetId!.value == budget.id.value) {
          spent += amount1;
        }
        if (transaction.isIncome) {
          final amount2 = transaction.budgetManagement![budget.id.value]!;
          budgeted += amount2;
        }
      }
      final savings = budgeted - spent;
      final percent = spent / budgeted;
      list.add(
        BudgetData(
          name: budget.name,
          abbreviation: budget.abbreviation,
          spent: spent,
          budgeted: budgeted,
          savings: savings,
          percent: percent.isNaN ? 0.0 : percent * 100,
          color: budget.color,
        ),
      );
    }
    return list.sorted(
      (a, b) => (b.spent).compareTo(a.spent),
    );
  }

  List<BudgetData> get budgetsDataSortedBySavings => budgetsData.sorted(
        (a, b) => (b.savings).compareTo(a.savings),
      );

  List<PieData> get expenseCategoriesData {
    if (expenses == 0) return [];

    final list = <PieData>[];
    final expenseCategories =
        categories.where((category) => category.type == CategoryType.expense);

    for (final category in expenseCategories) {
      var spent = 0.0;
      for (final transaction in filteredTransactions) {
        final amount = transaction.amount;
        if (transaction.txCategoryId!.value == category.id.value) {
          spent += amount;
        }
      }
      final percent = (spent / expenses).isNaN ? 0.0 : (spent / expenses);
      list.add(
        PieData(
          name: category.name,
          amount: spent,
          percent: percent,
          icon: category.icon,
          color: category.color,
        ),
      );
    }
    return list.sorted(
      (a, b) => (b.amount).compareTo(a.amount),
    );
  }

  List<PieData> get expenseBudgetsData {
    if (expenses == 0) return [];

    final list = <PieData>[];

    for (final budget in budgets) {
      var spent = 0.0;
      for (final transaction in filteredTransactions) {
        final amount = transaction.amount;
        if ([
          transaction.txBudgetId!.value == budget.id.value,
          transaction.isExpense
        ].flatten()) {
          spent += amount;
        }
      }
      final percent = (spent / expenses).isNaN ? 0.0 : (spent / expenses);
      list.add(
        PieData(
          name: budget.name,
          amount: spent,
          percent: percent,
          icon: 0xe33a,
          color: budget.color,
        ),
      );
    }
    return list.sorted(
      (a, b) => (b.amount).compareTo(a.amount),
    );
  }

  List<PieData> get expenseAccountsData {
    if (expenses == 0) return [];

    final list = <PieData>[];

    for (final account in accounts) {
      var spent = 0.0;
      for (final transaction in filteredTransactions) {
        final amount = transaction.amount;
        if ([
          transaction.txAccountId!.value == account.id.value,
          transaction.isExpense
        ].flatten()) {
          spent += amount;
        }
      }
      final percent = (spent / expenses).isNaN ? 0.0 : (spent / expenses);
      list.add(
        PieData(
          name: account.name,
          amount: spent,
          percent: percent,
          icon: account.icon,
          color: account.color,
        ),
      );
    }
    return list.sorted(
      (a, b) => (b.amount).compareTo(a.amount),
    );
  }

  List<PieData> get incomeCategoriesData {
    if (incomes == 0) return [];

    final list = <PieData>[];
    final incomeCategories =
        categories.where((category) => category.type == CategoryType.income);

    for (final category in incomeCategories) {
      var spent = 0.0;
      for (final transaction in filteredTransactions) {
        final amount = transaction.amount;
        if (transaction.txCategoryId!.value == category.id.value) {
          spent += amount;
        }
      }
      final percent = (spent / incomes).isNaN ? 0.0 : (spent / incomes);
      list.add(
        PieData(
          name: category.name,
          amount: spent,
          percent: percent,
          icon: category.icon,
          color: category.color,
        ),
      );
    }
    return list.sorted(
      (a, b) => (b.amount).compareTo(a.amount),
    );
  }

  List<PieData> get incomeAccountsData {
    if (incomes == 0) return [];

    final list = <PieData>[];

    for (final account in accounts) {
      var spent = 0.0;
      for (final transaction in filteredTransactions) {
        final amount = transaction.amount;
        if ([
          transaction.txAccountId!.value == account.id.value,
          transaction.isIncome
        ].flatten()) {
          spent += amount;
        }
      }
      final percent = (spent / incomes).isNaN ? 0.0 : (spent / incomes);
      list.add(
        PieData(
          name: account.name,
          amount: spent,
          percent: percent,
          icon: account.icon,
          color: account.color,
        ),
      );
    }
    return list.sorted(
      (a, b) => (b.amount).compareTo(a.amount),
    );
  }

  StatsState copyWith({
    Status? status,
    DateTime? date,
    List<Budget>? budgets,
    List<Category>? categories,
    List<Account>? accounts,
    List<Transaction>? transactions,
  }) {
    return StatsState(
      status: status ?? this.status,
      date: date ?? this.date,
      budgets: budgets ?? this.budgets,
      categories: categories ?? this.categories,
      accounts: accounts ?? this.accounts,
      transactions: transactions ?? this.transactions,
    );
  }
}

class BudgetData {
  final String name;
  final String? abbreviation;
  final double spent;
  final double budgeted;
  final double savings;
  final double percent;
  final int color;
  BudgetData({
    required this.name,
    this.abbreviation,
    required this.spent,
    required this.budgeted,
    required this.savings,
    required this.percent,
    required this.color,
  });
}

class PieData {
  final String name;
  final double amount;
  final double percent;
  final int icon;
  final int color;
  PieData({
    required this.name,
    required this.amount,
    required this.percent,
    required this.icon,
    required this.color,
  });
}
