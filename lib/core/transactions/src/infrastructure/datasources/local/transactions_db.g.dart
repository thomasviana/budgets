// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TransactionDbDto extends DataClass
    implements Insertable<TransactionDbDto> {
  final String id;
  final double amount;
  final DateTime date;
  final String note;
  final String? userId;
  final String? categoryId;
  final String? accountId;
  final String? budgetId;
  final IncomeTypeTable? incomeType;
  TransactionDbDto(
      {required this.id,
      required this.amount,
      required this.date,
      required this.note,
      this.userId,
      this.categoryId,
      this.accountId,
      this.budgetId,
      this.incomeType});
  factory TransactionDbDto.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TransactionDbDto(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}note'])!,
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      categoryId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      accountId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}account_id']),
      budgetId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}budget_id']),
      incomeType: $TransactionsTableTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}income_type'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['note'] = Variable<String>(note);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String?>(userId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String?>(categoryId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String?>(accountId);
    }
    if (!nullToAbsent || budgetId != null) {
      map['budget_id'] = Variable<String?>(budgetId);
    }
    if (!nullToAbsent || incomeType != null) {
      final converter = $TransactionsTableTable.$converter0;
      map['income_type'] = Variable<int?>(converter.mapToSql(incomeType));
    }
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      amount: Value(amount),
      date: Value(date),
      note: Value(note),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      budgetId: budgetId == null && nullToAbsent
          ? const Value.absent()
          : Value(budgetId),
      incomeType: incomeType == null && nullToAbsent
          ? const Value.absent()
          : Value(incomeType),
    );
  }

  factory TransactionDbDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDbDto(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String>(json['note']),
      userId: serializer.fromJson<String?>(json['userId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      budgetId: serializer.fromJson<String?>(json['budgetId']),
      incomeType: serializer.fromJson<IncomeTypeTable?>(json['incomeType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String>(note),
      'userId': serializer.toJson<String?>(userId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'accountId': serializer.toJson<String?>(accountId),
      'budgetId': serializer.toJson<String?>(budgetId),
      'incomeType': serializer.toJson<IncomeTypeTable?>(incomeType),
    };
  }

  TransactionDbDto copyWith(
          {String? id,
          double? amount,
          DateTime? date,
          String? note,
          String? userId,
          String? categoryId,
          String? accountId,
          String? budgetId,
          IncomeTypeTable? incomeType}) =>
      TransactionDbDto(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        note: note ?? this.note,
        userId: userId ?? this.userId,
        categoryId: categoryId ?? this.categoryId,
        accountId: accountId ?? this.accountId,
        budgetId: budgetId ?? this.budgetId,
        incomeType: incomeType ?? this.incomeType,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionDbDto(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('budgetId: $budgetId, ')
          ..write('incomeType: $incomeType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, date, note, userId, categoryId,
      accountId, budgetId, incomeType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionDbDto &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.note == this.note &&
          other.userId == this.userId &&
          other.categoryId == this.categoryId &&
          other.accountId == this.accountId &&
          other.budgetId == this.budgetId &&
          other.incomeType == this.incomeType);
}

class TransactionsTableCompanion extends UpdateCompanion<TransactionDbDto> {
  final Value<String> id;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String> note;
  final Value<String?> userId;
  final Value<String?> categoryId;
  final Value<String?> accountId;
  final Value<String?> budgetId;
  final Value<IncomeTypeTable?> incomeType;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.userId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.budgetId = const Value.absent(),
    this.incomeType = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    required String id,
    this.amount = const Value.absent(),
    required DateTime date,
    this.note = const Value.absent(),
    this.userId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.budgetId = const Value.absent(),
    this.incomeType = const Value.absent(),
  })  : id = Value(id),
        date = Value(date);
  static Insertable<TransactionDbDto> custom({
    Expression<String>? id,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<String?>? userId,
    Expression<String?>? categoryId,
    Expression<String?>? accountId,
    Expression<String?>? budgetId,
    Expression<IncomeTypeTable?>? incomeType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (userId != null) 'user_id': userId,
      if (categoryId != null) 'category_id': categoryId,
      if (accountId != null) 'account_id': accountId,
      if (budgetId != null) 'budget_id': budgetId,
      if (incomeType != null) 'income_type': incomeType,
    });
  }

  TransactionsTableCompanion copyWith(
      {Value<String>? id,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<String>? note,
      Value<String?>? userId,
      Value<String?>? categoryId,
      Value<String?>? accountId,
      Value<String?>? budgetId,
      Value<IncomeTypeTable?>? incomeType}) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      budgetId: budgetId ?? this.budgetId,
      incomeType: incomeType ?? this.incomeType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String?>(userId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String?>(categoryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String?>(accountId.value);
    }
    if (budgetId.present) {
      map['budget_id'] = Variable<String?>(budgetId.value);
    }
    if (incomeType.present) {
      final converter = $TransactionsTableTable.$converter0;
      map['income_type'] = Variable<int?>(converter.mapToSql(incomeType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('budgetId: $budgetId, ')
          ..write('incomeType: $incomeType')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionDbDto> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TransactionsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double?> amount = GeneratedColumn<double?>(
      'amount', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String?> note = GeneratedColumn<String?>(
      'note', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'user_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String?> categoryId = GeneratedColumn<String?>(
      'category_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String?> accountId = GeneratedColumn<String?>(
      'account_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _budgetIdMeta = const VerificationMeta('budgetId');
  @override
  late final GeneratedColumn<String?> budgetId = GeneratedColumn<String?>(
      'budget_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _incomeTypeMeta = const VerificationMeta('incomeType');
  @override
  late final GeneratedColumnWithTypeConverter<IncomeTypeTable?, int?>
      incomeType = GeneratedColumn<int?>('income_type', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<IncomeTypeTable?>($TransactionsTableTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        amount,
        date,
        note,
        userId,
        categoryId,
        accountId,
        budgetId,
        incomeType
      ];
  @override
  String get aliasedName => _alias ?? 'transactions';
  @override
  String get actualTableName => 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionDbDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    }
    if (data.containsKey('budget_id')) {
      context.handle(_budgetIdMeta,
          budgetId.isAcceptableOrUnknown(data['budget_id']!, _budgetIdMeta));
    }
    context.handle(_incomeTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionDbDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TransactionDbDto.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(_db, alias);
  }

  static TypeConverter<IncomeTypeTable?, int> $converter0 =
      const EnumIndexConverter<IncomeTypeTable>(IncomeTypeTable.values);
}

abstract class _$TransactionsDatabase extends GeneratedDatabase {
  _$TransactionsDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final TransactionDao transactionDao =
      TransactionDao(this as TransactionsDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [transactionsTable];
}
