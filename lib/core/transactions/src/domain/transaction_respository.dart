import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class TxRepository {
  Future<Option<List<Tx>>> fetchTransactions(
    TxUserId userId,
  );

  Future<void> save(Tx transaction);

  Future<void> delete(TxId txId);
}
