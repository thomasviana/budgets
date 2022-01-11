import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';
import '../../domain.dart';

class Expense extends Tx {
  TxBudgetId? txBudgetId;

  Expense({
    required TxId id,
    double amount = 0,
    required DateTime date,
    String note = '',
    this.txBudgetId,
    TxUserId? txUserId,
    TxAccountId? txAccountId,
    TxCategoryId? txCategoryId,
  }) : super(
          id: id,
          amount: amount,
          date: date,
          note: note,
          txUserId: txUserId,
          txAccountId: txAccountId,
          txCategoryId: txCategoryId,
        );

  // ignore: use_setters_to_change_properties
  void updateBudgetId(TxBudgetId? newBudgetId) => txBudgetId = newBudgetId;

  factory Expense.empty() => Expense(
        id: TxId.auto(),
        date: DateTime.now(),
      );

  factory Expense.rent() => Expense(
        id: TxId.auto(),
        date: DateTime.now(),
      );

  factory Expense.gas() => Expense(
        id: TxId.auto(),
        date: DateTime.now(),
      );

  static List<Expense> get defaultExpenses {
    return [
      Expense.rent(),
      Expense.gas(),
    ];
  }
}

class TxBudgetId extends AlphanumericId {
  const TxBudgetId(String value) : super(value);

  TxBudgetId.auto() : this(const Uuid().v1());
}
