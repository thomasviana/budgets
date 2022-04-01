part of 'home_screen_bloc.dart';

class HomeScreenState extends MyState {
  final UserEntity user;

  HomeScreenState({
    required Status status,
    required this.user,
  }) : super(status: status);

  factory HomeScreenState.initial() => HomeScreenState(
        status: Status.initial,
        user: UserEntity.empty(),
      );

  HomeScreenState copyWith({
    Status? status,
    UserEntity? user,
  }) {
    return HomeScreenState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
