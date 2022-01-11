import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';

class Tx extends Entity<TxId> {
  double amount = 0;
  DateTime date;
  String note;
  TxUserId? txUserId;
  TxCategoryId? txCategoryId;
  TxAccountId? txAccountId;

  Tx({
    required TxId id,
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
  void setUserId(TxUserId? userId) => txUserId = userId;
  // ignore: use_setters_to_change_properties
  void updateCategoryId(TxCategoryId? categoryId) => txCategoryId = categoryId;
  // ignore: use_setters_to_change_properties
  void updateAccountId(TxAccountId? accountId) => txAccountId = accountId;
}

class TxId extends AlphanumericId {
  const TxId(String value) : super(value);

  TxId.auto() : this(const Uuid().v1());
}

class TxUserId extends AlphanumericId {
  const TxUserId(String value) : super(value);

  TxUserId.auto() : this(const Uuid().v1());
}

class TxCategoryId extends AlphanumericId {
  const TxCategoryId(String value) : super(value);

  TxCategoryId.auto() : this(const Uuid().v1());
}

class TxAccountId extends AlphanumericId {
  const TxAccountId(String value) : super(value);

  TxAccountId.auto() : this(const Uuid().v1());
}
