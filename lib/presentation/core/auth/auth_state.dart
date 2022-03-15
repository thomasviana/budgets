part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState._({
    this.status = AuthStatus.unauthenticated,
  });

  const AuthState.authenticated() : this._(status: AuthStatus.authenticated);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  // TODO: implement props
  List<Object?> get props => [status];
}
