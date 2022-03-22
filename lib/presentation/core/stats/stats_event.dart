part of 'stats_bloc.dart';

abstract class StatsEvent {}

class GetUserBudgets extends StatsEvent {}

class GetUserCategories extends StatsEvent {}

class TransactionsSuscriptionRequested extends StatsEvent {}

class BudgetsInfoRequested extends StatsEvent {}

class DataRequested extends StatsEvent {}

class StatsDateUpdated extends StatsEvent {
  final DateTime date;
  StatsDateUpdated({
    required this.date,
  });
}
