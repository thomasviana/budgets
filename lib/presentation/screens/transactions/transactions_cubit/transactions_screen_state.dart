part of 'transactions_screen_cubit.dart';

class TransactionsScreenState {
  final bool isLoading;
  List<Transaction> transactions;
  List<SubCategory> subCategories;

  TransactionsScreenState({
    required this.isLoading,
    required this.transactions,
    required this.subCategories,
  });

  factory TransactionsScreenState.initial() => TransactionsScreenState(
      isLoading: false, transactions: [], subCategories: []);

  TransactionsScreenState copyWith({
    bool? isLoading,
    List<Transaction>? transactions,
    List<SubCategory>? subCategories,
  }) {
    return TransactionsScreenState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}
