part of 'transactions_screen_bloc.dart';

class TransactionsScreenState {
  final bool isLoading;
  List<Transaction> transactions;
  DateTime date;

  TransactionsScreenState({
    required this.isLoading,
    required this.transactions,
    required this.date,
  });

  List<Transaction> get filteredTransactions {
    final filteredTransactions = transactions
        .where((transaction) => transaction.date.month == date.month)
        .toList();
    return filteredTransactions;
  }

  factory TransactionsScreenState.initial() => TransactionsScreenState(
        isLoading: false,
        transactions: [],
        date: DateTime.now(),
      );

  TransactionsScreenState copyWith({
    bool? isLoading,
    List<Transaction>? transactions,
    DateTime? date,
  }) {
    return TransactionsScreenState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
      date: date ?? this.date,
    );
  }

  List<DateTime> get filteredDates => transactions
      .map((transaction) => transaction.date)
      .toList()
      .where((element) => element.month == date.month)
      .toList();
}
