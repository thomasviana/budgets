part of 'stats_bloc.dart';

class StatsState extends MyState with EquatableMixin {
  final DateTime date;
  final List<Budget> budgets;
  final List<Category> categories;
  final List<Transaction> transactions;

  StatsState({
    required Status status,
    required this.date,
    required this.budgets,
    required this.categories,
    required this.transactions,
  }) : super(status: status);

  factory StatsState.initial() => StatsState(
        status: Status.initial,
        date: DateTime.now(),
        budgets: [],
        categories: [],
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
      final percent = spent / budgeted;
      list.add(
        BudgetData(
          name: budget.name,
          abbreviation: budget.abbreviation,
          spent: spent,
          budgeted: budgeted,
          percent: percent.isNaN ? 0.0 : percent * 100,
        ),
      );
    }
    return list.sorted(
      (a, b) => (b.spent).compareTo(a.spent),
    );
  }

  List<PieData> get expenseCategoriesData {
    final list = <PieData>[];
    final expenseCategories =
        categories.where((category) => category.type == CategoryType.expense);

    for (final category in expenseCategories) {
      var spent = 0.0;
      var total = 0.0;
      for (final transaction in filteredTransactions) {
        final amount = transaction.amount;
        if (transaction.txCategoryId!.value == category.id.value) {
          spent += amount;
        }
        total += amount;
      }
      final percent = (spent / total).isNaN ? 0.0 : (spent / total);
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

  List<PieData> get incomeCategoriesData {
    final list = <PieData>[];
    final incomeCategories =
        categories.where((category) => category.type == CategoryType.income);

    for (final category in incomeCategories) {
      var spent = 0.0;
      var total = 0.0;
      for (final transaction in filteredTransactions) {
        final amount = transaction.amount;
        if (transaction.txCategoryId!.value == category.id.value) {
          spent += amount;
        }
        total += amount;
      }
      final percent = (spent / total).isNaN ? 0.0 : (spent / total);
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

  StatsState copyWith({
    Status? status,
    DateTime? date,
    List<Budget>? budgets,
    List<Category>? categories,
    List<Transaction>? transactions,
  }) {
    return StatsState(
      status: status ?? this.status,
      date: date ?? this.date,
      budgets: budgets ?? this.budgets,
      categories: categories ?? this.categories,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [status, date, budgets, categories, transactions];
}

class BudgetData {
  final String name;
  final String? abbreviation;
  final double spent;
  final double budgeted;
  final double percent;
  BudgetData({
    required this.name,
    this.abbreviation,
    required this.spent,
    required this.budgeted,
    required this.percent,
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
