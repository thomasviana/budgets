part of 'edit_transaction_screen_bloc.dart';

abstract class EditTransactionScreenEvent {}

class CheckTransaction extends EditTransactionScreenEvent {
  final Transaction? transaction;
  CheckTransaction({this.transaction});
}

class GetUserSubcategories extends EditTransactionScreenEvent {}

class TransactionDeleted extends EditTransactionScreenEvent {}

class TransactionSaved extends EditTransactionScreenEvent {
  final double amount;
  final DateTime date;
  TransactionSaved({
    required this.amount,
    required this.date,
  });
}

class TransactionTypeChanged extends EditTransactionScreenEvent {
  final int? index;
  TransactionTypeChanged({
    this.index,
  });
}

class AmountUpdated extends EditTransactionScreenEvent {
  final double amount;
  AmountUpdated({
    required this.amount,
  });
}

class AccountSelected extends EditTransactionScreenEvent {
  final Account account;
  AccountSelected({
    required this.account,
  });
}

class CategorySelected extends EditTransactionScreenEvent {
  final Category category;
  CategorySelected({
    required this.category,
  });
}

class SubCategorySelected extends EditTransactionScreenEvent {
  final SubCategory subCategory;
  SubCategorySelected({
    required this.subCategory,
  });
}

class BudgetSelected extends EditTransactionScreenEvent {
  final Budget budget;
  BudgetSelected({
    required this.budget,
  });
}

class DateUpdated extends EditTransactionScreenEvent {
  final DateTime date;
  DateUpdated({
    required this.date,
  });
}

class NoteUpdated extends EditTransactionScreenEvent {
  final String note;
  NoteUpdated({
    required this.note,
  });
}

class IncomeManagementDone extends EditTransactionScreenEvent {}
