part of 'manage_income_screen_bloc.dart';

abstract class ManageIncomeScreenEvent {}

class CheckInitialValues extends ManageIncomeScreenEvent {
  final Transaction transaction;
  final List<Budget>? budgets;
  CheckInitialValues({
    required this.transaction,
    this.budgets,
  });
}

class BudgetIncremented extends ManageIncomeScreenEvent {
  int index;
  BudgetIncremented({
    required this.index,
  });
}

class BudgetDecremented extends ManageIncomeScreenEvent {
  int index;
  BudgetDecremented({
    required this.index,
  });
}

class IncomeManaged extends ManageIncomeScreenEvent {}
