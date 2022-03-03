part of 'home_screen_bloc.dart';

class HomeScreenState {
  final UserEntity user;
  final DateTime date;
  final List<Budget> budgets;
  final Map<Budget, Map<String, double>> budgetsInfo;
  final List<Transaction> transactions;
  final bool isLoading;
  HomeScreenState({
    required this.user,
    required this.date,
    required this.budgets,
    required this.budgetsInfo,
    required this.transactions,
    required this.isLoading,
  });

  List<Transaction> get filteredTransactions {
    final filteredTransactions = transactions
        .where((transaction) => transaction.date.month == date.month)
        .toList();
    return filteredTransactions;
  }

  factory HomeScreenState.initial() => HomeScreenState(
        user: UserEntity.empty(),
        budgets: [],
        budgetsInfo: {},
        transactions: [],
        date: DateTime.now(),
        isLoading: true,
      );

  HomeScreenState copyWith({
    UserEntity? user,
    DateTime? date,
    List<Budget>? budgets,
    Map<Budget, Map<String, double>>? budgetsInfo,
    List<Transaction>? transactions,
    bool? isLoading,
  }) {
    return HomeScreenState(
      user: user ?? this.user,
      date: date ?? this.date,
      budgets: budgets ?? this.budgets,
      budgetsInfo: budgetsInfo ?? this.budgetsInfo,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
