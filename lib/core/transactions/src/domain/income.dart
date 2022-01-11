import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';
import '../../domain.dart';

enum IncomeType { active, pasive }

class Income extends Tx {
  IncomeType? type;

  Income({
    required TxId id,
    this.type,
    double amount = 0,
    required DateTime date,
    String note = '',
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
  void updateType(IncomeType? newType) => type = newType;

  factory Income.empty() => Income(
        id: TxId.auto(),
        type: IncomeType.active,
        date: DateTime.now(),
      );

  factory Income.salary() => Income(
        id: TxId.auto(),
        type: IncomeType.active,
        date: DateTime.now(),
      );

  factory Income.investment() => Income(
        id: TxId.auto(),
        type: IncomeType.pasive,
        date: DateTime.now(),
      );

  static List<Income> get defaultIncomes {
    return [
      Income.salary(),
      Income.investment(),
    ];
  }
}

class IncomeId extends AlphanumericId {
  const IncomeId(String value) : super(value);

  IncomeId.auto() : this(const Uuid().v1());
}
