import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class AccountRepository {
  Stream<Option<List<Account>>> fetchAccounts(
    AccountUserId userId,
  );

  Future<void> save(Account account);

  Future<void> saveList(List<Account> accounts);

  Future<void> delete(AccountId accountId);
}
