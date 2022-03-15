import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
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
    final user = await _getProfileInfo().first;
    if (user != null) {
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
    }
  }
}
