part of 'transactions_bloc.dart';

class TransactionsState extends MyState {
  List<Transaction> transactions;
  DateTime date;

  TransactionsState({
    required Status status,
    required this.transactions,
    required this.date,
  }) : super(status: status);

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
        status: Status.initial,
        transactions: [],
        date: DateTime.now(),
      );

  TransactionsState copyWith({
    Status? status,
    List<Transaction>? transactions,
    DateTime? date,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      date: date ?? this.date,
    );
  }
}
