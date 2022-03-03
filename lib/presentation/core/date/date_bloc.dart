import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

part 'date_event.dart';
part 'date_state.dart';

@injectable
class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(DateState.initial()) {
    on<MonthIncremented>(
      (event, emit) => emit(
        state.copyWith(date: DateTime(state.date.year, state.date.month + 1)),
      ),
    );

    on<MonthDecremented>(
      (event, emit) => emit(
        state.copyWith(date: DateTime(state.date.year, state.date.month - 1)),
      ),
    );
  }
}
