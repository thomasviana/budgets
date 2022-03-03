import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetTransactions {
  final TransactionRepository _transactionRepository;
  final GetProfileInfo _getProfileInfo;

  const GetTransactions(
    this._transactionRepository,
    this._getProfileInfo,
  );

  Stream<Option<List<Transaction>>> call() async* {
    final userId = await _getProfileInfo().then(
      (userOption) => userOption.fold(
        () => null,
        (user) => TransactionUserId(user.id.value),
      ),
    );
    if (userId != null) {
      yield* _transactionRepository.fetchTransactions(userId);
    }
  }
}
