import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';

class Transaction extends Entity<TransactionId> {
  double amount = 0;
  DateTime date;
  String note;
  TransactionUserId? txUserId;
  TransactionCategoryId? txCategoryId;
  TransactionAccountId? txAccountId;

  Transaction({
    required TransactionId id,
    required this.amount,
    required this.date,
    required this.note,
    this.txUserId,
    this.txCategoryId,
    this.txAccountId,
  }) : super(id);

  // ignore: use_setters_to_change_properties
  void updateAmount(double newAmount) => amount = newAmount;
  // ignore: use_setters_to_change_properties
  void updateDate(DateTime newDate) => date = newDate;
  // ignore: use_setters_to_change_properties
  void updateNote(String newNote) => note = newNote;
  // ignore: use_setters_to_change_properties
  void setUserId(TransactionUserId? userId) => txUserId = userId;
  // ignore: use_setters_to_change_properties
  void updateCategoryId(TransactionCategoryId? categoryId) =>
      txCategoryId = categoryId;
  // ignore: use_setters_to_change_properties
  void updateAccountId(TransactionAccountId? accountId) =>
      txAccountId = accountId;
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
