import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionsLocalDataSource _transactionslocalDataSource;

  TransactionRepositoryImpl(
    this._transactionslocalDataSource,
  );

  @override
  Future<void> delete(TransactionId budgetId) {
    return _transactionslocalDataSource.deleteTransaction(budgetId);
  }

  @override
  Stream<Option<List<Transaction>>> fetchTransactions(
      TransactionUserId userId) {
    return _transactionslocalDataSource.getCachedTransactions(userId);
  }

  @override
  Future<void> save(Transaction budget) {
    return _transactionslocalDataSource.cacheTransaction(budget);
  }
}
