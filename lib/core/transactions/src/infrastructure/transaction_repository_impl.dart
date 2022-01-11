import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: TxRepository)
class TxRepositoryImpl implements TxRepository {
  final TxsLocalDataSource _budgetslocalDataSource;

  TxRepositoryImpl(
    this._budgetslocalDataSource,
  );

  @override
  Future<void> delete(TxId budgetId) {
    return _budgetslocalDataSource.deleteTx(budgetId);
  }

  @override
  Future<Option<List<Tx>>> fetchTransactions(TxUserId userId) {
    return _budgetslocalDataSource.getCachedTxs(userId);
  }

  @override
  Future<void> save(Tx budget) {
    return _budgetslocalDataSource.cacheTx(budget);
  }
}
