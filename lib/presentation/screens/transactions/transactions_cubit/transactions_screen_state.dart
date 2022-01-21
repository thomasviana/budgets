part of 'transactions_screen_cubit.dart';

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
}
