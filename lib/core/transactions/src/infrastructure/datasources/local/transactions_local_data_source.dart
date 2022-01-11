import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class TxsLocalDataSource {
  Future<void> cacheTx(Tx transaction);
  Future<void> cacheTxs(List<Tx> transactions);
  Future<Option<List<Tx>>> getCachedTxs(TxUserId userId);
  Future<void> deleteTx(TxId transactionId);
}

@LazySingleton(as: TxsLocalDataSource)
class TxsLocalDataSourceImpl implements TxsLocalDataSource {
  final TxDao _transactionDao;
  final TxMapper _transactionMapper;

  TxsLocalDataSourceImpl(
    this._transactionDao,
    this._transactionMapper,
  );

  @override
  Future<void> cacheTx(Tx transaction) {
    return Future.value(_transactionMapper.toDbDto(transaction))
        .then((campanion) => _transactionDao.createOrUpdate(campanion));
  }

  @override
  Future<void> cacheTxs(List<Tx> transactions) {
    return Future.value(_transactionMapper.toDbDtoList(transactions)).then(
      (campanions) => {
        for (var campanion in campanions)
          {_transactionDao.createOrUpdate(campanion)}
      },
    );
  }

  @override
  Future<void> deleteTx(TxId transactionId) {
    return _transactionDao.deleteTx(transactionId.value);
  }

  @override
  Future<Option<List<Tx>>> getCachedTxs(
    TxUserId userId,
  ) async {
    final transactions = await _transactionDao
        .getTxs(userId.value)
        .map((dtos) => _transactionMapper.fromDbDtoList(dtos))
        .first;
    if (transactions.isNotEmpty) {
      return some(transactions);
    } else {
      return none();
    }
  }
}
