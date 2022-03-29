part of 'stats_bloc.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
  @override
  List<Object> get props => [];
}

class UpdateSettings extends StatsEvent {
  final SettingsState settings;

  const UpdateSettings({required this.settings});

  @override
  List<Object> get props => [settings];
}

class BudgetsSuscriptionRequested extends StatsEvent {}

class CategoriesSuscriptionRequested extends StatsEvent {}

class AccountsSuscriptionRequested extends StatsEvent {}

class TransactionsSuscriptionRequested extends StatsEvent {}

class BudgetsInfoRequested extends StatsEvent {}

class DataRequested extends StatsEvent {}

class StatsDateUpdated extends StatsEvent {
  final DateTime date;
  const StatsDateUpdated({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}
