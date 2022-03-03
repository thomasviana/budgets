part of 'date_bloc.dart';

abstract class DateEvent {}

class MonthIncremented extends DateEvent {}

class MonthDecremented extends DateEvent {}
