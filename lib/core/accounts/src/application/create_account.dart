import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateAccount {
  final AccountRepository _accountRepository;

  const CreateAccount(this._accountRepository);

  Future<void> call({
    required String name,
    required int icon,
    required int color,
    String? imageUrl,
    required AccountUserId accountUserId,
  }) {
    return _accountRepository.save(
      Account(
        id: AccountId.auto(),
        name: name,
        icon: icon,
        color: color,
        imageUrl:
            imageUrl ?? 'https://www.csvtasaciones.com/images/cash-icon.png',
        accountUserId: accountUserId,
      ),
    );
  }
}
