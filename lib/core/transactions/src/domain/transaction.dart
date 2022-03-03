import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';
import '../../../../presentation/resources/resources.dart';

enum TransactionType { expense, income }
enum IncomeType { active, pasive }

typedef BudgetManagementMap = Map<String, Map<String, double>>;

class Transaction extends Entity<TransactionId> {
  TransactionType transactionType;
  String? title;
  double amount;
  DateTime date;
  String? note;
  int icon;
  int color;
  TransactionUserId? txUserId;
  TransactionCategoryId? txCategoryId;
  TransactionSubCategoryId? txSubCategoryId;
  TransactionAccountId? txAccountId;
  TransactionBudgetId? txBudgetId;
  IncomeType? incomeType;
  bool isIncomeManaged;
  BudgetManagementMap? budgetManagement;

  Transaction({
    required TransactionId id,
    required this.transactionType,
    this.title = '',
    this.amount = 0,
    required this.date,
    this.note = '',
    required this.icon,
    required this.color,
    this.txUserId,
    this.txCategoryId,
    this.txSubCategoryId,
    this.txAccountId,
    this.txBudgetId,
    this.incomeType = IncomeType.active,
    this.isIncomeManaged = false,
    this.budgetManagement,
  }) : super(id);

  bool get isIncome => transactionType == TransactionType.income;
  bool get isExpense => transactionType == TransactionType.expense;

  factory Transaction.empty() => Transaction(
        id: TransactionId.auto(),
        transactionType: TransactionType.expense,
        date: DateTime.now(),
        icon: 0xe5f9,
        color: AppColors.primaryColor.value,
      );

  Transaction copyWith({
    TransactionType? transactionType,
    String? title,
    double? amount,
    DateTime? date,
    String? note,
    int? icon,
    int? color,
    TransactionUserId? txUserId,
    TransactionCategoryId? txCategoryId,
    TransactionSubCategoryId? txSubCategoryId,
    TransactionAccountId? txAccountId,
    TransactionBudgetId? txBudgetId,
    IncomeType? incomeType,
    bool? isIncomeManaged,
    BudgetManagementMap? budgetManagement,
  }) {
    return Transaction(
      id: id,
      transactionType: transactionType ?? this.transactionType,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      txUserId: txUserId ?? this.txUserId,
      txCategoryId: txCategoryId ?? this.txCategoryId,
      txSubCategoryId: txSubCategoryId ?? this.txSubCategoryId,
      txAccountId: txAccountId ?? this.txAccountId,
      txBudgetId: txBudgetId ?? this.txBudgetId,
      incomeType: incomeType ?? this.incomeType,
      isIncomeManaged: isIncomeManaged ?? this.isIncomeManaged,
      budgetManagement: budgetManagement ?? this.budgetManagement,
    );
  }
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

class TransactionSubCategoryId extends AlphanumericId {
  const TransactionSubCategoryId(String value) : super(value);

  TransactionSubCategoryId.auto() : this(const Uuid().v1());
}

class TransactionAccountId extends AlphanumericId {
  const TransactionAccountId(String value) : super(value);

  TransactionAccountId.auto() : this(const Uuid().v1());
}

class TransactionBudgetId extends AlphanumericId {
  const TransactionBudgetId(String value) : super(value);

  TransactionBudgetId.auto() : this(const Uuid().v1());
}
