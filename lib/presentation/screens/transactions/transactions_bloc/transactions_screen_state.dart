part of 'transactions_screen_bloc.dart';

class TransactionsScreenState {
  final bool isLoading;
  List<Transaction> transactions;

  TransactionsScreenState({
    required this.isLoading,
    required this.transactions,
  });

  factory TransactionsScreenState.initial() => TransactionsScreenState(
        isLoading: false,
        transactions: [],
      );

  TransactionsScreenState copyWith({
    bool? isLoading,
    List<Transaction>? transactions,
  }) {
    return TransactionsScreenState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
    );
  }

  List<DateTime> get dates => transactions
      .map((transaction) => DateTime(
            transaction.date.year,
            transaction.date.month,
            transaction.date.day,
          ))
      .toList()
      .where((date) => date.month == 2 || date.month == 1)
      .toList();
}
