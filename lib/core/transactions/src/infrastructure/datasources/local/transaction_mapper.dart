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
    final subCategoryId = TransactionSubCategoryId(dto.subCategoryId!);
    final budgetId = TransactionBudgetId(dto.budgetId!);
    final txType = TransactionType.values[dto.transactionType.index];
    final incomeType = IncomeType.values[dto.incomeType!.index];

    return Transaction(
      id: id,
      transactionType: txType,
      title: dto.title,
      amount: dto.amount,
      date: dto.date,
      note: dto.note,
      icon: dto.icon,
      color: dto.color,
      txUserId: userId,
      txAccountId: accountId,
      txCategoryId: categoryId,
      txSubCategoryId: subCategoryId,
      txBudgetId: budgetId,
      incomeType: incomeType,
      isIncomeManaged: dto.isIncomeManaged,
      budgetManagement: dto.budgetManagement!.budgetToAmount,
    );
  }

  List<Transaction> fromDbDtoList(List<TransactionDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  TransactionsTableCompanion toDbDto(Transaction transaction) {
    final incomeType = IncomeTypeTable.values[transaction.incomeType!.index];
    final transactionType =
        TransactionTypeTable.values[transaction.transactionType.index];
    final BudgetManagement budgetManagement =
        BudgetManagement(budgetToAmount: transaction.budgetManagement);
    return TransactionsTableCompanion(
      id: Value(transaction.id.value),
      transactionType: Value(transactionType),
      title: Value(transaction.title!),
      amount: Value(transaction.amount),
      date: Value(transaction.date),
      note: Value(transaction.note!),
      icon: Value(transaction.icon),
      color: Value(transaction.color),
      userId: Value(transaction.txUserId!.value),
      accountId: Value(transaction.txAccountId!.value),
      categoryId: Value(transaction.txCategoryId!.value),
      subCategoryId: Value(transaction.txSubCategoryId!.value),
      budgetId: Value(transaction.txBudgetId!.value),
      incomeType: Value(incomeType),
      isIncomeManaged: Value(transaction.isIncomeManaged),
      budgetManagement: Value(budgetManagement),
    );
  }

  List<TransactionsTableCompanion> toDbDtoList(List<Transaction> transactions) {
    return transactions.map((transaction) => toDbDto(transaction)).toList();
  }
}
