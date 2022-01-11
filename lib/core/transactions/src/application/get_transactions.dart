import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class GetTransactions {
  final TxRepository _budgetRepository;

  const GetTransactions(
    this._budgetRepository,
  );

  Future<Option<List<Tx>>> call(TxUserId userId) =>
      _budgetRepository.fetchTransactions(userId);
}
