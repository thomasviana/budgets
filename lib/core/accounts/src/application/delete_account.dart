import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class DeleteAccount {
  final AccountRepository _accountRepository;

  const DeleteAccount(this._accountRepository);

  Future<void> call(AccountId accountId) {
    return _accountRepository.delete(accountId);
  }
}
