import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class SetDefaultAccounts {
  final GetProfileInfo _getProfileInfo;
  final AccountRepository _accountRepository;

  const SetDefaultAccounts(
    this._getProfileInfo,
    this._accountRepository,
  );

  Future<void> call() async {
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) {
          final accounts = Account.defaultAccounts;
          for (final account in accounts) {
            account.setUserId(user.id.value);
          }
          _accountRepository.saveList(accounts);
        },
      ),
    );
  }
}
