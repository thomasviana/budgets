part of 'transactions_screen_bloc.dart';

abstract class TransactionScreenEvent {}

class GetUserTransactions extends TransactionScreenEvent {
  final Transaction? transaction;
  GetUserTransactions({this.transaction});
}
