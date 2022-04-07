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
  int step;
  BudgetIncremented({
    required this.index,
    required this.step,
  });
}

class BudgetDecremented extends ManageIncomeScreenEvent {
  int index;
  int step;
  BudgetDecremented({
    required this.index,
    required this.step,
  });
}
