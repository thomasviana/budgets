import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class GetTransactions {
  final TransactionRepository _transactionRepository;

  const GetTransactions(
    this._transactionRepository,
  );

  Stream<Option<List<Transaction>>> call(TransactionUserId userId) =>
      _transactionRepository.fetchTransactions(userId);
}
