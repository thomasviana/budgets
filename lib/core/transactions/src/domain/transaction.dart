import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';

enum TransactionType { expense, income }
enum IncomeType { active, pasive }

class Transaction extends Entity<TransactionId> {
  TransactionType transactionType;
  double amount = 0;
  DateTime date;
  String note;
  int? icon;
  int? color;
  TransactionUserId? txUserId;
  TransactionCategoryId? txCategoryId;
  TransactionAccountId? txAccountId;
  TransactionBudgetId? txBudgetId;
  IncomeType? incomeType;

  Transaction({
    required TransactionId id,
    required this.transactionType,
    required this.amount,
    required this.date,
    required this.note,
    this.icon,
    this.color,
    this.txUserId,
    this.txCategoryId,
    this.txAccountId,
    this.txBudgetId,
    this.incomeType,
  }) : super(id);

  bool get isIncome => transactionType == TransactionType.income;
  bool get isExpense => transactionType == TransactionType.expense;

  // ignore: use_setters_to_change_properties
  void changeType(TransactionType newType) => transactionType = newType;
  // ignore: use_setters_to_change_properties
  void updateAmount(double newAmount) => amount = newAmount;
  // ignore: use_setters_to_change_properties
  void updateDate(DateTime newDate) => date = newDate;
  // ignore: use_setters_to_change_properties
  void updateNote(String newNote) => note = newNote;
  // ignore: use_setters_to_change_properties
  void updateIcon(int? newIcon) => icon = newIcon;
  // ignore: use_setters_to_change_properties
  void updateColor(int? newColor) => color = newColor;
  // ignore: use_setters_to_change_properties
  void setUserId(TransactionUserId? userId) => txUserId = userId;
  // ignore: use_setters_to_change_properties
  void updateCategoryId(TransactionCategoryId? categoryId) =>
      txCategoryId = categoryId;
  // ignore: use_setters_to_change_properties
  void updateAccountId(TransactionAccountId? accountId) =>
      txAccountId = accountId;
  // ignore: use_setters_to_change_properties
  void updateBudgetId(TransactionBudgetId? newBudgetId) =>
      txBudgetId = newBudgetId;
  // ignore: use_setters_to_change_properties
  void updateIncomeType(IncomeType? newType) => incomeType = newType;

  factory Transaction.empty() => Transaction(
        id: TransactionId.auto(),
        transactionType: TransactionType.expense,
        amount: 0,
        date: DateTime.now(),
        note: '',
      );
}

class TransactionId extends AlphanumericId {
  const TransactionId(String value) : super(value);

  TransactionId.auto() : this(const Uuid().v1());
}

class TransactionUserId extends AlphanumericId {
  const TransactionUserId(String value) : super(value);

  TransactionUserId.auto() : this(const Uuid().v1());
}

class TransactionCategoryId extends AlphanumericId {
  const TransactionCategoryId(String value) : super(value);

  TransactionCategoryId.auto() : this(const Uuid().v1());
}

class TransactionAccountId extends AlphanumericId {
  const TransactionAccountId(String value) : super(value);

  TransactionAccountId.auto() : this(const Uuid().v1());
}

class TransactionBudgetId extends AlphanumericId {
  const TransactionBudgetId(String value) : super(value);

  TransactionBudgetId.auto() : this(const Uuid().v1());
}
