import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

@lazySingleton
class TxMapper {
  const TxMapper();

  Tx fromDbDto(TxDbDto dto) {
    final id = TxId(dto.id);
    final userId = TxUserId(dto.userId!);
    final accountId = TxAccountId(dto.accountId!);
    final categoryId = TxCategoryId(dto.categoryId!);

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
      final budgetId = TxBudgetId(dto.budgetId!);
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

  List<Tx> fromDbDtoList(List<TxDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  TxsTableCompanion toDbDto(Tx tx) {
    final incomeType = IncomeTypeTable.values[(tx as Income).type!.index];
    return TxsTableCompanion(
      id: Value(tx.id.value),
      amount: Value(tx.amount),
      date: Value(tx.date),
      note: Value(tx.note),
      userId: Value(tx.txUserId!.value),
      accountId: Value(tx.txAccountId!.value),
      categoryId: Value(tx.txCategoryId!.value),
      budgetId: Value((tx as Expense).txBudgetId!.value),
      incomeType: Value(incomeType),
    );
  }

  List<TxsTableCompanion> toDbDtoList(List<Tx> txs) {
    return txs.map((tx) => toDbDto(tx)).toList();
  }
}
