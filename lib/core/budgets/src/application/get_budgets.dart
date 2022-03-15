import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetBudgets {
  final BudgetRepository _budgetRepository;
  final GetProfileInfo _getProfileInfo;

  const GetBudgets(
    this._budgetRepository,
    this._getProfileInfo,
  );

  Stream<Option<List<Budget>>> call() async* {
    final user = await _getProfileInfo().first;
    if (user != null) {
      yield* _budgetRepository.fetchBudgets(BudgetUserId(user.id.value));
    }
  }
}
