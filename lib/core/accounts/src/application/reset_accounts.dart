import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class ResetAccounts {
  final AccountRepository _accountRepository;

  const ResetAccounts(
    this._accountRepository,
  );

  Future<void> call() async {
    _accountRepository.deleteAll();
  }
}
