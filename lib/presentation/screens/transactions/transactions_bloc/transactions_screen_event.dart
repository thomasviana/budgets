part of 'transactions_screen_bloc.dart';

abstract class TransactionScreenEvent {}

class GetUserTransactions extends TransactionScreenEvent {
  final DateTime date;
  GetUserTransactions({
    required this.date,
  });
}

class TransactionDeleted extends TransactionScreenEvent {
  final TransactionId transactionId;
  TransactionDeleted({
    required this.transactionId,
  });
}

class DateUpdated extends TransactionScreenEvent {
  final DateTime date;
  DateUpdated({
    required this.date,
  });
}
