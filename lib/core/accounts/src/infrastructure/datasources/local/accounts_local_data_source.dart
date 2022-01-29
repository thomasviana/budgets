import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class AccountsLocalDataSource {
  Future<void> cacheAccount(Account account);
  Future<void> cacheAccounts(List<Account> accounts);
  Stream<Option<List<Account>>> getCachedAccounts(AccountUserId userId);
  Future<void> deleteAccount(AccountId accountId);
}

@LazySingleton(as: AccountsLocalDataSource)
class AccountsLocalDataSourceImpl implements AccountsLocalDataSource {
  final AccountDao _accountDao;
  final AccountMapper _accountMapper;

  AccountsLocalDataSourceImpl(
    this._accountDao,
    this._accountMapper,
  );

  @override
  Future<void> cacheAccount(Account account) {
    return Future.value(_accountMapper.toDbDto(account))
        .then((campanion) => _accountDao.createOrUpdate(campanion));
  }

  @override
  Future<void> cacheAccounts(List<Account> accounts) {
    return Future.value(_accountMapper.toDbDtoList(accounts)).then(
      (campanions) => {
        for (var campanion in campanions)
          {_accountDao.createOrUpdate(campanion)}
      },
    );
  }

  @override
  Future<void> deleteAccount(AccountId accountId) {
    return _accountDao.deleteAccount(accountId.value);
  }

  @override
  Stream<Option<List<Account>>> getCachedAccounts(
    AccountUserId userId,
  ) =>
      _accountDao
          .getAccounts(userId.value)
          .map((dtos) => optionOf(_accountMapper.fromDbDtoList(dtos)));
}
