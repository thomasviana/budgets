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
    bool? isIncomeManaged,
    TransactionType? txType,
    BudgetManagementMap? budgetManagement,
  }) async {
    final transaction = await _getTransactions().first.then(
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
        transaction.copyWith(
          transactionType: txType,
          title: title,
          amount: amount,
          date: date,
          note: note,
          icon: icon,
          color: color,
          txAccountId: txAccountId,
          txCategoryId: txCategoryId,
          txBudgetId: txBudgetId,
          incomeType: incomeType,
          isIncomeManaged: isIncomeManaged,
          budgetManagement: budgetManagement,
        ),
      );
    }
  }
}
