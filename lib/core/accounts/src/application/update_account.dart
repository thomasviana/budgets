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
    required AccountUserId userId,
    required AccountId accountId,
    String? name,
    AccountType? type,
    int? color,
    String? imageUrl,
    double? balance,
  }) async {
    final account = await _getAccounts(userId).then(
      (accounts) => accounts.fold(
        () => null,
        (accounts) => accounts.firstWhere(
          (account) => account.id == accountId,
          orElse: () => throw Exception("Account doesn't exist."),
        ),
      ),
    );
    if (account != null) {
      _accountRepository.save(
        account
          ..updateName(name ?? account.name)
          ..updateType(type ?? account.type)
          ..updateColor(color ?? account.color)
          ..updateImageUrl(imageUrl)
          ..updateBalance(balance ?? account.balance),
      );
    }
  }
}
