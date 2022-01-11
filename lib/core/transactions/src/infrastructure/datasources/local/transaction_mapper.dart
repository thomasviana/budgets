import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

@lazySingleton
class TransactionMapper {
  const TransactionMapper();

  Transaction fromDbDto(TransactionDbDto dto) {
    final id = TransactionId(dto.id);
    final userId = TransactionUserId(dto.userId!);
    final accountId = TransactionAccountId(dto.accountId!);
    final categoryId = TransactionCategoryId(dto.categoryId!);

    if (dto.incomeType != null) {
      final incomeType = IncomeType.values[dto.incomeType!.index];
      return Income(
        id: id,
        type: incomeType,
        amount: dto.amount,
        date: dto.date,
        note: dto.note,
        txUserId: userId,
        txAccountId: accountId,
        txCategoryId: categoryId,
      );
    } else {
      final budgetId = TransactionBudgetId(dto.budgetId!);
      return Expense(
        id: id,
        amount: dto.amount,
        date: dto.date,
        note: dto.note,
        txBudgetId: budgetId,
        txUserId: userId,
        txAccountId: accountId,
        txCategoryId: categoryId,
      );
    }
  }

  List<Transaction> fromDbDtoList(List<TransactionDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  TransactionsTableCompanion toDbDto(Transaction transaction) {
    final incomeType =
        IncomeTypeTable.values[(transaction as Income).type!.index];
    return TransactionsTableCompanion(
      id: Value(transaction.id.value),
      amount: Value(transaction.amount),
      date: Value(transaction.date),
      note: Value(transaction.note),
      userId: Value(transaction.txUserId!.value),
      accountId: Value(transaction.txAccountId!.value),
      categoryId: Value(transaction.txCategoryId!.value),
      budgetId: Value((transaction as Expense).txBudgetId!.value),
      incomeType: Value(incomeType),
    );
  }

  List<TransactionsTableCompanion> toDbDtoList(List<Transaction> transactions) {
    return transactions.map((transaction) => toDbDto(transaction)).toList();
  }
}
