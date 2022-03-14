import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Status { initial, loading, success, failure }

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
}

abstract class MyState extends Equatable {
  final Status status;

  const MyState({
    this.status = Status.initial,
  });

  @override
  List<Object?> get props => [status];
}

class Observer<Bloc, State> extends StatelessWidget {
  final StateStreamable<MyState> bloc;
  @required
  final Widget Function(BuildContext context, MyState? state) onSuccess;

  final Widget Function(BuildContext context, MyState? state)? onFailure;

  const Observer({
    Key? key,
    required this.bloc,
    required this.onSuccess,
    this.onFailure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StateStreamable<MyState>, MyState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.status) {
          case Status.initial:
            return const SizedBox();
          case Status.loading:
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case Status.success:
            return onSuccess(context, state);
          case Status.failure:
            return onFailure!(context, state);
          default:
            return SizedBox();
        }
      },
    );
  }
}
