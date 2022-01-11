import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';
import '../../domain.dart';

class Expense extends Transaction {
  TransactionBudgetId? txBudgetId;

  Expense({
    required TransactionId id,
    double amount = 0,
    required DateTime date,
    String note = '',
    this.txBudgetId,
    TransactionUserId? txUserId,
    TransactionAccountId? txAccountId,
    TransactionCategoryId? txCategoryId,
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
  void updateBudgetId(TransactionBudgetId? newBudgetId) =>
      txBudgetId = newBudgetId;

  factory Expense.empty() => Expense(
        id: TransactionId.auto(),
        date: DateTime.now(),
      );

  factory Expense.rent() => Expense(
        id: TransactionId.auto(),
        date: DateTime.now(),
      );

  factory Expense.gas() => Expense(
        id: TransactionId.auto(),
        date: DateTime.now(),
      );

  static List<Expense> get defaultExpenses {
    return [
      Expense.rent(),
      Expense.gas(),
    ];
  }
}

class TransactionBudgetId extends AlphanumericId {
  const TransactionBudgetId(String value) : super(value);

  TransactionBudgetId.auto() : this(const Uuid().v1());
}
