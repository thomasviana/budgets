part of 'edit_transaction_screen_bloc.dart';

abstract class EditTransactionScreenEvent {}

class CheckTransaction extends EditTransactionScreenEvent {
  final Transaction? transaction;
  final List<Account> accounts;
  final List<SubCategory> subCategories;
  final List<Budget> budgets;
  CheckTransaction({
    this.transaction,
    required this.accounts,
    required this.subCategories,
    required this.budgets,
  });
}

class GetUserSubcategories extends EditTransactionScreenEvent {}

class GetAllUserSubcategories extends EditTransactionScreenEvent {}

class SearchSubCategory extends EditTransactionScreenEvent {
  final String query;
  SearchSubCategory({required this.query});
}

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

class IncomeTypeChanged extends EditTransactionScreenEvent {
  final int? index;
  IncomeTypeChanged({
    this.index,
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

class IncomeManagementDone extends EditTransactionScreenEvent {
  final BudgetManagementMap budgetsInfo;
  IncomeManagementDone({
    required this.budgetsInfo,
  });
}

class Dispose extends EditTransactionScreenEvent {}
