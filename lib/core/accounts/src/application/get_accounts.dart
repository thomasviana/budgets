import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetAccounts {
  final AccountRepository _accountRepository;
  final GetProfileInfo _getProfileInfo;

  const GetAccounts(
    this._accountRepository,
    this._getProfileInfo,
  );

  Stream<Option<List<Account>>> call() async* {
    final user = await _getProfileInfo().first;
    if (user != null) {
      yield* _accountRepository.fetchAccounts(AccountUserId(user.id.value));
    }
  }
}
