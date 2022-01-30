part of 'edit_budget_screen_bloc.dart';

abstract class EditBudgetScreenEvent {}

class CheckBudget extends EditBudgetScreenEvent {
  final Budget? budget;
  CheckBudget({this.budget});
}

class BudgetDeleted extends EditBudgetScreenEvent {}

class BudgetSaved extends EditBudgetScreenEvent {}

class ColorUpdated extends EditBudgetScreenEvent {
  final int color;
  ColorUpdated(this.color);
}

class NameChanged extends EditBudgetScreenEvent {
  final String name;
  NameChanged(this.name);
}

class AbbreviationChanged extends EditBudgetScreenEvent {
  final String abbreviation;
  AbbreviationChanged(this.abbreviation);
}

class BalanceChanged extends EditBudgetScreenEvent {
  final double balance;
  BalanceChanged(this.balance);
}
