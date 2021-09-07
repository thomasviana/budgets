import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsState(title: 'title', amount: 100));

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {}
}
