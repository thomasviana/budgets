part of 'accounts_screen_cubit.dart';

class AccountsScreenState {
  final bool isLoading;
  List<Account> accounts;
  UserEntity? user;

  AccountsScreenState({
    required this.isLoading,
    required this.accounts,
    this.user,
  });

  factory AccountsScreenState.initial() => AccountsScreenState(
        isLoading: false,
        accounts: Account.defaultAccounts,
      );

  AccountsScreenState copyWith({
    bool? isLoading,
    List<Account>? accounts,
    UserEntity? user,
  }) {
    return AccountsScreenState(
      isLoading: isLoading ?? this.isLoading,
      accounts: accounts ?? this.accounts,
      user: user ?? this.user,
    );
  }
}
