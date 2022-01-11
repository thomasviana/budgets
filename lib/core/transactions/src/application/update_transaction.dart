import 'package:injectable/injectable.dart';

import '../../application.dart';
import '../../domain.dart';

@injectable
class UpdateTx {
  final TxRepository _txRepository;
  final GetTransactions _getTransactions;

  const UpdateTx(
    this._txRepository,
    this._getTransactions,
  );

  Future<void> call({
    required TxUserId userId,
    required TxId txId,
    double? amount,
    DateTime? date,
    String? note,
    TxAccountId? txAccountId,
    TxCategoryId? txCategoryId,
    TxBudgetId? txBudgetId,
    IncomeType? incomeType,
  }) async {
    final tx = await _getTransactions(userId).then(
      (txs) => txs.fold(
        () => null,
        (txs) => txs.firstWhere(
          (tx) => tx.id == txId,
          orElse: () => throw Exception("Tx doesn't exist."),
        ),
      ),
    );
    if (tx != null && tx is Income) {
      _txRepository.save(
        tx
          ..updateAmount(amount ?? tx.amount)
          ..updateDate(date ?? tx.date)
          ..updateNote(note ?? tx.note)
          ..updateType(incomeType ?? tx.type)
          ..updateAccountId(txAccountId ?? tx.txAccountId)
          ..updateCategoryId(txCategoryId ?? tx.txCategoryId),
      );
    } else if (tx != null && tx is Expense) {
      _txRepository.save(
        tx
          ..updateAmount(amount ?? tx.amount)
          ..updateDate(date ?? tx.date)
          ..updateNote(note ?? tx.note)
          ..updateBudgetId(txBudgetId ?? tx.txBudgetId)
          ..updateAccountId(txAccountId ?? tx.txAccountId)
          ..updateCategoryId(txCategoryId ?? tx.txCategoryId),
      );
    }
  }
}
