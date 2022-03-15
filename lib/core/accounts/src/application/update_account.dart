import 'package:injectable/injectable.dart';

import '../../domain.dart';
import 'get_accounts.dart';

@injectable
class UpdateAccount {
  final AccountRepository _accountRepository;
  final GetAccounts _getAccounts;

  const UpdateAccount(
    this._accountRepository,
    this._getAccounts,
  );

  Future<void> call({
    required AccountId accountId,
    String? name,
    AccountType? type,
    int? color,
    String? imageUrl,
    double? amount,
  }) async {
    final account = await _getAccounts().first.then(
          (accounts) => accounts.fold(
            () {},
            (accounts) => accounts.firstWhere(
              (account) => account.id == accountId,
              orElse: () => throw Exception("Account doesn't exist."),
            ),
          ),
        );

    if (account != null) {
      _accountRepository.save(
        account.copyWith(
          name: name,
          type: type,
          color: color,
          imageUrl: imageUrl,
          balance: account.balance + (amount ?? 0),
        ),
      );
    }
  }
}
