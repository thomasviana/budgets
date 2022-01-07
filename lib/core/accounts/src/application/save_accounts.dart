import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class SaveCategories {
  final AccountRepository _accountRepository;

  const SaveCategories(this._accountRepository);

  Future<void> call({
    required List<Account> accounts,
  }) {
    return _accountRepository.saveList(accounts);
  }
}
