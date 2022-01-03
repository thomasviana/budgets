part of 'auth_cubit.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isUnauthenticated;
  final UserEntity userEntity;
  final List<Category> categories;

  AuthState({
    required this.isAuthenticated,
    required this.isUnauthenticated,
    required this.userEntity,
    required this.categories,
  });

  factory AuthState.initial() => AuthState(
        isAuthenticated: false,
        isUnauthenticated: true,
        userEntity: UserEntity.empty(),
        categories: [],
      );

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isUnauthenticated,
    UserEntity? userEntity,
    List<Category>? categories,
  }) =>
      AuthState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isUnauthenticated: isUnauthenticated ?? this.isUnauthenticated,
        userEntity: userEntity ?? this.userEntity,
        categories: categories ?? this.categories,
      );
}
