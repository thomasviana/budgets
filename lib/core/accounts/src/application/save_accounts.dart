import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class SaveAccounts {
  final AccountRepository _accountRepository;

  const SaveAccounts(this._accountRepository);

  Future<void> call({
    required List<Account> accounts,
  }) {
    return _accountRepository.saveList(accounts);
  }
}
