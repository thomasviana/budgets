import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CreateAccount {
  final AccountRepository _accountRepository;
  final GetProfileInfo _getProfileInfo;

  const CreateAccount(
    this._accountRepository,
    this._getProfileInfo,
  );

  Future<void> call({
    required String name,
    required AccountType type,
    required int color,
    String? imageUrl,
  }) async {
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) {
          _accountRepository.save(
            Account(
              id: AccountId.auto(),
              name: name,
              type: type,
              color: color,
              imageUrl: imageUrl,
              accountUserId: AccountUserId(user.id.value),
            ),
          );
        },
      ),
    );
  }
}
