part of 'transactions_bloc.dart';

@immutable
class TransactionsState {
  final String title;
  final double amount;

  TransactionsState({
    required this.title,
    required this.amount,
  });
}
