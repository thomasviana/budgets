part of 'manage_income_screen_bloc.dart';

abstract class ManageIncomeScreenEvent {}

class CheckInitialValues extends ManageIncomeScreenEvent {
  final List<Budget>? budgets;
  final double incomeAmount;
  CheckInitialValues({
    this.budgets,
    required this.incomeAmount,
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
