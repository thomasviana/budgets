import 'package:injectable/injectable.dart';

import '../../domain.dart';

enum TxType { income, expense }

@injectable
class AddTransaction {
  final TxRepository _txRepository;

  const AddTransaction(this._txRepository);

  Future<void>? call({
    required TxType txType,
    required double amount,
    required DateTime date,
    required String note,
    required TxUserId txUserId,
    required TxCategoryId txCategoryId,
    required TxAccountId txAccountId,
    required TxBudgetId txBudgetId,
    IncomeType? incomeType,
  }) {
    if (txType == TxType.income) {
      return _txRepository.save(
        Income(
          id: TxId.auto(),
          type: incomeType,
          amount: amount,
          date: date,
          note: note,
          txUserId: txUserId,
          txAccountId: txAccountId,
          txCategoryId: txCategoryId,
        ),
      );
    } else if (txType == TxType.expense) {
      return _txRepository.save(
        Expense(
          id: TxId.auto(),
          amount: amount,
          date: date,
          note: note,
          txBudgetId: txBudgetId,
          txUserId: txUserId,
          txAccountId: txAccountId,
          txCategoryId: txCategoryId,
        ),
      );
    }
  }
}
