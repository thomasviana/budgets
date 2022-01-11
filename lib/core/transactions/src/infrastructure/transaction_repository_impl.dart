import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionsLocalDataSource _budgetslocalDataSource;

  TransactionRepositoryImpl(
    this._budgetslocalDataSource,
  );

  @override
  Future<void> delete(TransactionId budgetId) {
    return _budgetslocalDataSource.deleteTransaction(budgetId);
  }

  @override
  Future<Option<List<Transaction>>> fetchTransactions(
      TransactionUserId userId) {
    return _budgetslocalDataSource.getCachedTransactions(userId);
  }

  @override
  Future<void> save(Transaction budget) {
    return _budgetslocalDataSource.cacheTransaction(budget);
  }
}
