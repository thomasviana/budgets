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

  BudgetManagementMap get budgetsInfo {
    final map = <String, Map<String, double>>{};
    for (final budget in budgets) {
      map.putIfAbsent(budget.id.value, () {
        var spent = 0.0;
        var budgeted = 0.0;
        for (final transaction in filteredTransactions) {
          final newAmount1 =
              transaction.budgetManagement![budget.id.value]!['spent']!;
          spent += newAmount1;
          final newAmount2 =
              transaction.budgetManagement![budget.id.value]!['budgeted']!;
          budgeted += newAmount2;
        }
        return {'spent': spent, 'budgeted': budgeted};
      });
    }
    return map;
  }

  List<CategoryData> get categoriesInfo {
    final list = <CategoryData>[];
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
      final percent = spent / total;
      list.add(
        CategoryData(
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
  List<Object?> get props =>
      [status, date, budgets, categories, transactions, budgetsInfo];
}

class CategoryData {
  final String name;
  final double amount;
  final double percent;
  final int icon;
  final int color;
  CategoryData({
    required this.name,
    required this.amount,
    required this.percent,
    required this.icon,
    required this.color,
  });
}
