part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStatusRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}
