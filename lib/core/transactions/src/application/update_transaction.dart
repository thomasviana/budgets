import 'package:injectable/injectable.dart';

import '../../application.dart';
import '../../domain.dart';

@injectable
class UpdateTransaction {
  final TransactionRepository _transactionRepository;
  final GetTransactions _getTransactions;

  const UpdateTransaction(
    this._transactionRepository,
    this._getTransactions,
  );

  Future<void> call({
    required TransactionUserId txUserId,
    required TransactionId transactionId,
    String? title,
    double? amount,
    DateTime? date,
    String? note,
    int? icon,
    int? color,
    TransactionAccountId? txAccountId,
    TransactionCategoryId? txCategoryId,
    TransactionBudgetId? txBudgetId,
    IncomeType? incomeType,
    TransactionType? txType,
  }) async {
    final transaction = await _getTransactions(txUserId).first.then(
          (transactions) => transactions.fold(
            () => null,
            (transactions) => transactions.firstWhere(
              (transaction) => transaction.id == transactionId,
              orElse: () => throw Exception("Transaction doesn't exist."),
            ),
          ),
        );
    if (transaction != null) {
      _transactionRepository.save(
        transaction
          ..changeType(txType ?? transaction.transactionType)
          ..updateTitle(title ?? transaction.title)
          ..updateAmount(amount ?? transaction.amount)
          ..updateDate(date ?? transaction.date)
          ..updateNote(note ?? transaction.note)
          ..updateIcon(icon ?? transaction.icon)
          ..updateColor(color ?? transaction.color)
          ..updateAccountId(txAccountId ?? transaction.txAccountId)
          ..updateCategoryId(txCategoryId ?? transaction.txCategoryId)
          ..updateBudgetId(txBudgetId ?? transaction.txBudgetId)
          ..updateIncomeType(incomeType ?? transaction.incomeType),
      );
    }
  }
}
