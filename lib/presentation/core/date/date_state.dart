part of 'date_bloc.dart';

class DateState {
  DateTime date;

  DateState({
    required this.date,
  });

  factory DateState.initial() => DateState(
        date: DateTime.now(),
      );

  DateState copyWith({
    DateTime? date,
  }) {
    return DateState(
      date: date ?? this.date,
    );
  }
}
