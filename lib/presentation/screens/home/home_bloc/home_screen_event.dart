part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent {}

class BudgetsInfoRequested extends HomeScreenEvent {
  final List<Budget> budgets;
  BudgetsInfoRequested({
    required this.budgets,
  });
}
