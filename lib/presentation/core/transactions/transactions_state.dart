part of 'transactions_bloc.dart';

class TransactionsState {
  final bool isLoading;
  List<Transaction> transactions;
  DateTime date;

  TransactionsState({
    required this.isLoading,
    required this.transactions,
    required this.date,
  });

  List<Transaction> get filteredTransactions {
    final filteredTransactions = transactions
        .where((transaction) => transaction.date.month == date.month)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return filteredTransactions;
  }

  List<DateTime> get filteredDates => transactions
      .map((transaction) => transaction.date)
      .toList()
      .where((element) => element.month == date.month)
      .toList()
    ..sort(((a, b) => b.day.compareTo(a.day)));

  factory TransactionsState.initial() => TransactionsState(
        isLoading: true,
        transactions: [],
        date: DateTime.now(),
      );

  TransactionsState copyWith({
    bool? isLoading,
    List<Transaction>? transactions,
    DateTime? date,
  }) {
    return TransactionsState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
      date: date ?? this.date,
    );
  }
}
