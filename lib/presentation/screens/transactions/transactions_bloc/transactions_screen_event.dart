part of 'transactions_screen_bloc.dart';

abstract class TransactionScreenEvent {}

class GetUserTransactions extends TransactionScreenEvent {
  final Transaction? transaction;
  GetUserTransactions({this.transaction});
}

class TransactionDeleted extends TransactionScreenEvent {
  final TransactionId transactionId;
  TransactionDeleted({
    required this.transactionId,
  });
}

class MonthIncremented extends TransactionScreenEvent {}

class MonthDecremented extends TransactionScreenEvent {}
