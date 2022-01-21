import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class AddTransaction {
  final TransactionRepository _transactionRepository;

  const AddTransaction(this._transactionRepository);

  Future<void>? call({
    required TransactionType txType,
    required String title,
    required double amount,
    required DateTime date,
    required String note,
    required int icon,
    required int color,
    required TransactionUserId txUserId,
    required TransactionCategoryId txCategoryId,
    required TransactionAccountId txAccountId,
    required TransactionBudgetId txBudgetId,
    IncomeType? incomeType,
  }) {
    return _transactionRepository.save(
      Transaction(
        id: TransactionId.auto(),
        transactionType: txType,
        title: title,
        amount: amount,
        date: date,
        note: note,
        icon: icon,
        color: color,
        txUserId: txUserId,
        txAccountId: txAccountId,
        txCategoryId: txCategoryId,
        txBudgetId: txBudgetId,
        incomeType: incomeType,
      ),
    );
  }
}
