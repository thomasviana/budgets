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
    required TransactionUserId userId,
    required TransactionId transactionId,
    double? amount,
    DateTime? date,
    String? note,
    TransactionAccountId? txAccountId,
    TransactionCategoryId? txCategoryId,
    TransactionBudgetId? txBudgetId,
    IncomeType? incomeType,
    TransactionType? txType,
  }) async {
    final transaction = await _getTransactions(userId).then(
      (transactions) => transactions.fold(
        () => null,
        (transactions) => transactions.firstWhere(
          (transaction) => transaction.id == transactionId,
          orElse: () => throw Exception("Transaction doesn't exist."),
        ),
      ),
    );
    if (transaction != null && transaction is Income) {
      _transactionRepository.save(
        transaction
          ..updateAmount(amount ?? transaction.amount)
          ..updateDate(date ?? transaction.date)
          ..updateNote(note ?? transaction.note)
          ..updateType(incomeType ?? transaction.type)
          ..updateAccountId(txAccountId ?? transaction.txAccountId)
          ..updateCategoryId(txCategoryId ?? transaction.txCategoryId)
          ..changeType(txType ?? transaction.transactionType),
      );
    } else if (transaction != null && transaction is Expense) {
      _transactionRepository.save(
        transaction
          ..updateAmount(amount ?? transaction.amount)
          ..updateDate(date ?? transaction.date)
          ..updateNote(note ?? transaction.note)
          ..updateBudgetId(txBudgetId ?? transaction.txBudgetId)
          ..updateAccountId(txAccountId ?? transaction.txAccountId)
          ..updateCategoryId(txCategoryId ?? transaction.txCategoryId)
          ..changeType(txType ?? transaction.transactionType),
      );
    }
  }
}
