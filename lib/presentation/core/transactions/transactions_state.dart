part of 'transactions_bloc.dart';

enum SortOption { ascending, descending }

class TransactionsState extends MyState {
  List<Transaction> transactions;
  DateTime date;
  SortOption sortOption;

  TransactionsState({
    required Status status,
    required this.transactions,
    required this.date,
    required this.sortOption,
  }) : super(status: status);

  List<Transaction> get filteredTransactions {
    final filteredTransactions = transactions
        .where((transaction) => transaction.date.month == date.month)
        .toList()
      ..sort(
        (a, b) => sortOption == SortOption.descending
            ? b.date.compareTo(a.date)
            : a.date.compareTo(b.date),
      );
    return filteredTransactions;
  }

  List<DateTime> get filteredDates => transactions
      .map((transaction) => transaction.date)
      .toList()
      .where((element) => element.month == date.month)
      .toList()
    ..sort(
      (a, b) => sortOption == SortOption.descending
          ? b.day.compareTo(a.day)
          : a.day.compareTo(b.day),
    );

  factory TransactionsState.initial() => TransactionsState(
        status: Status.initial,
        transactions: [],
        date: DateTime.now(),
        sortOption: SortOption.descending,
      );

  TransactionsState copyWith({
    Status? status,
    List<Transaction>? transactions,
    DateTime? date,
    SortOption? sortOption,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      date: date ?? this.date,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}
