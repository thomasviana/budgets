import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetTransactions {
  final TransactionRepository _transactionRepository;
  final GetProfileInfo _getProfileInfo;

  const GetTransactions(
    this._transactionRepository,
    this._getProfileInfo,
  );

  Stream<Option<List<Transaction>>> call() async* {
    final user = await _getProfileInfo().first;
    if (user != null) {
      yield* _transactionRepository
          .fetchTransactions(TransactionUserId(user.id.value));
    }
  }
}
