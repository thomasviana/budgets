import 'package:budgets/core/accounts/src/application/get_accounts.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

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
  }) async {
    final account = await _getAccounts(userId).then(
      (accounts) => accounts.fold(
        () => null,
        (accounts) => accounts.firstWhere(
          (account) => account.id == accountId,
          orElse: () => throw Exception("Category doesn't exist."),
        ),
      ),
    );
    if (account != null) {
      _accountRepository.save(
        account
          ..updateName(name ?? account.name)
          ..updateType(type ?? account.type)
          ..updateColor(color ?? account.color)
          ..updateImageUrl(imageUrl),
      );
    }
  }
}
