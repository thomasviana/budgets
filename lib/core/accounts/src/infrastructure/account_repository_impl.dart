import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl implements AccountRepository {
  final AccountsLocalDataSource _accountslocalDataSource;

  AccountRepositoryImpl(
    this._accountslocalDataSource,
  );

  @override
  Stream<Option<List<Account>>> fetchAccounts(AccountUserId userId) {
    return _accountslocalDataSource.getCachedAccounts(userId);
  }

  @override
  Future<void> save(Account account) {
    return _accountslocalDataSource.cacheAccount(account);
  }

  @override
  Future<void> saveList(List<Account> accounts) {
    return _accountslocalDataSource.cacheAccounts(accounts);
  }

  @override
  Future<void> delete(AccountId accountId) {
    return _accountslocalDataSource.deleteAccount(accountId);
  }

  @override
  Future<void> deleteAll() {
    return _accountslocalDataSource.deleteAllAccounts();
  }
}
