import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class TransactionRepository {
  Stream<Option<List<Transaction>>> fetchTransactions(
    TransactionUserId userId,
  );

  Future<void> save(Transaction transaction);

  Future<void> delete(TransactionId txId);
}
