import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateAccount {
  final AccountRepository _accountRepository;

  const CreateAccount(this._accountRepository);

  Future<void> call({
    required String name,
    required AccountType type,
    required int color,
    String? imageUrl,
    required double balance,
    required AccountUserId accountUserId,
  }) {
    return _accountRepository.save(
      Account(
        id: AccountId.auto(),
        name: name,
        type: type,
        color: color,
        imageUrl: imageUrl,
        balance: balance,
        accountUserId: accountUserId,
      ),
    );
  }
}
