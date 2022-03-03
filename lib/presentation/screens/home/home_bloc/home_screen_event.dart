part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent {}

class HomeScreenInfoRequested extends HomeScreenEvent {
  final UserEntity user;
  final List<Transaction> transactions;
  final List<Budget> budgets;
  final DateTime date;
  HomeScreenInfoRequested({
    required this.user,
    required this.transactions,
    required this.budgets,
    required this.date,
  });
}

class BudgetsInfoRequested extends HomeScreenEvent {}
