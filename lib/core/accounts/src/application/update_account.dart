import 'package:budgets/core/accounts/src/application/get_accounts.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class UpdateCategory {
  final AccountRepository _accountRepository;
  final GetAccounts _getAccounts;

  const UpdateCategory(
    this._accountRepository,
    this._getAccounts,
  );

  Future<void> call({
    required AccountUserId userId,
    required AccountId accountId,
    String? name,
    int? icon,
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
          ..updateIcon(icon ?? account.icon)
          ..updateColor(color ?? account.color)
          ..updateImageUrl(imageUrl ?? account.imageUrl),
      );
    }
  }
}
