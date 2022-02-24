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
    TransactionUserId? txUserId,
    TransactionCategoryId? txCategoryId,
    TransactionSubCategoryId? txSubCategoryId,
    TransactionAccountId? txAccountId,
    TransactionBudgetId? txBudgetId,
    IncomeType? incomeType,
    bool isIncomeManaged = false,
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
        txSubCategoryId: txSubCategoryId,
        txBudgetId: txBudgetId,
        incomeType: incomeType,
        isIncomeManaged: isIncomeManaged,
      ),
    );
  }
}
