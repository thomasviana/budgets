import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class TransactionRepository {
  Future<Option<List<Transaction>>> fetchTransactions(
    TransactionUserId userId,
  );

  Future<void> save(Transaction transaction);

  Future<void> delete(TransactionId txId);
}
