import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class GetAccounts {
  final AccountRepository _accountRepository;

  const GetAccounts(
    this._accountRepository,
  );

  Future<Option<List<Account>>> call(AccountUserId userId) =>
      _accountRepository.fetchAccounts(userId);
}
