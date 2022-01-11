import 'package:injectable/injectable.dart';

import '../../domain.dart';

enum TransactionType { income, expense }

@injectable
class AddTransaction {
  final TransactionRepository _transactionRepository;

  const AddTransaction(this._transactionRepository);

  Future<void>? call({
    required TransactionType txType,
    required double amount,
    required DateTime date,
    required String note,
    required TransactionUserId txUserId,
    required TransactionCategoryId txCategoryId,
    required TransactionAccountId txAccountId,
    required TransactionBudgetId txBudgetId,
    IncomeType? incomeType,
  }) {
    if (txType == TransactionType.income) {
      return _transactionRepository.save(
        Income(
          id: TransactionId.auto(),
          type: incomeType,
          amount: amount,
          date: date,
          note: note,
          txUserId: txUserId,
          txAccountId: txAccountId,
          txCategoryId: txCategoryId,
        ),
      );
    } else if (txType == TransactionType.expense) {
      return _transactionRepository.save(
        Expense(
          id: TransactionId.auto(),
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
