part of 'transactions_bloc.dart';

abstract class TransactionEvent {}

class TransactionsRequested extends TransactionEvent {}

class TransactionDeleted extends TransactionEvent {
  final TransactionId transactionId;
  TransactionDeleted({
    required this.transactionId,
  });
}

class TxsDateUpdated extends TransactionEvent {
  final DateTime date;
  TxsDateUpdated({
    required this.date,
  });
}

class ToggleSortOption extends TransactionEvent {}
