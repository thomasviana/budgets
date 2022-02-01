import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class TransactionsLocalDataSource {
  Future<void> cacheTransaction(Transaction transaction);
  Future<void> cacheTransactions(List<Transaction> transactions);
  Stream<Option<List<Transaction>>> getCachedTransactions(
      TransactionUserId userId);
  Future<void> deleteTransaction(TransactionId transactionId);
}

@LazySingleton(as: TransactionsLocalDataSource)
class TransactionsLocalDataSourceImpl implements TransactionsLocalDataSource {
  final TransactionDao _transactionDao;
  final TransactionMapper _transactionMapper;

  TransactionsLocalDataSourceImpl(
    this._transactionDao,
    this._transactionMapper,
  );

  @override
  Future<void> cacheTransaction(Transaction transaction) {
    return Future.value(_transactionMapper.toDbDto(transaction))
        .then((campanion) => _transactionDao.createOrUpdate(campanion));
  }

  @override
  Future<void> cacheTransactions(List<Transaction> transactions) {
    return Future.value(_transactionMapper.toDbDtoList(transactions)).then(
      (campanions) => {
        for (var campanion in campanions)
          {_transactionDao.createOrUpdate(campanion)}
      },
    );
  }

  @override
  Future<void> deleteTransaction(TransactionId transactionId) {
    return _transactionDao.deleteTransaction(transactionId.value);
  }

  @override
  Stream<Option<List<Transaction>>> getCachedTransactions(
    TransactionUserId userId,
  ) =>
      _transactionDao.getTransactions(userId.value).map((dtos) =>
          dtos.isEmpty ? none() : some(_transactionMapper.fromDbDtoList(dtos)));
}
