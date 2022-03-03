part of 'transactions_bloc.dart';

abstract class TransactionEvent {}

class TransactionsRequested extends TransactionEvent {}

class TransactionDeleted extends TransactionEvent {
  final TransactionId transactionId;
  TransactionDeleted({
    required this.transactionId,
  });
}

class DateUpdated extends TransactionEvent {
  final DateTime date;
  DateUpdated({
    required this.date,
  });
}
