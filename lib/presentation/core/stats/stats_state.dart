part of 'stats_bloc.dart';

class StatsState extends MyState with EquatableMixin {
  final DateTime date;
  final List<Budget> budgets;
  final List<Transaction> transactions;

  StatsState({
    required Status status,
    required this.date,
    required this.budgets,
    required this.transactions,
  }) : super(status: status);

  factory StatsState.initial() => StatsState(
        status: Status.initial,
        date: DateTime.now(),
        budgets: [],
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

  StatsState copyWith({
    Status? status,
    DateTime? date,
    List<Budget>? budgets,
    List<Transaction>? transactions,
  }) {
    return StatsState(
      status: status ?? this.status,
      date: date ?? this.date,
      budgets: budgets ?? this.budgets,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [status, date, budgets, transactions, budgetsInfo];
}
