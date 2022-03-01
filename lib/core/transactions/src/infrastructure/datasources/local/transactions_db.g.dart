// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TransactionDbDto extends DataClass
    implements Insertable<TransactionDbDto> {
  final String id;
  final TransactionTypeTable transactionType;
  final String title;
  final double amount;
  final DateTime date;
  final String note;
  final int icon;
  final int color;
  final String? userId;
  final String? categoryId;
  final String? subCategoryId;
  final String? accountId;
  final String? budgetId;
  final IncomeTypeTable? incomeType;
  final bool isIncomeManaged;
  final BudgetManagement? budgetManagement;
  TransactionDbDto(
      {required this.id,
      required this.transactionType,
      required this.title,
      required this.amount,
      required this.date,
      required this.note,
      required this.icon,
      required this.color,
      this.userId,
      this.categoryId,
      this.subCategoryId,
      this.accountId,
      this.budgetId,
      this.incomeType,
      required this.isIncomeManaged,
      this.budgetManagement});
  factory TransactionDbDto.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TransactionDbDto(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      transactionType: $TransactionsTableTable.$converter0.mapToDart(
          const IntType().mapFromDatabaseResponse(
              data['${effectivePrefix}transaction_type']))!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}note'])!,
      icon: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}icon'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      categoryId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      subCategoryId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sub_category_id']),
      accountId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}account_id']),
      budgetId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}budget_id']),
      incomeType: $TransactionsTableTable.$converter1.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}income_type'])),
      isIncomeManaged: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_income_managed'])!,
      budgetManagement: $TransactionsTableTable.$converter2.mapToDart(
          const StringType().mapFromDatabaseResponse(
              data['${effectivePrefix}budget_management'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      final converter = $TransactionsTableTable.$converter0;
      map['transaction_type'] =
          Variable<int>(converter.mapToSql(transactionType)!);
    }
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['note'] = Variable<String>(note);
    map['icon'] = Variable<int>(icon);
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String?>(userId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String?>(categoryId);
    }
    if (!nullToAbsent || subCategoryId != null) {
      map['sub_category_id'] = Variable<String?>(subCategoryId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String?>(accountId);
    }
    if (!nullToAbsent || budgetId != null) {
      map['budget_id'] = Variable<String?>(budgetId);
    }
    if (!nullToAbsent || incomeType != null) {
      final converter = $TransactionsTableTable.$converter1;
      map['income_type'] = Variable<int?>(converter.mapToSql(incomeType));
    }
    map['is_income_managed'] = Variable<bool>(isIncomeManaged);
    if (!nullToAbsent || budgetManagement != null) {
      final converter = $TransactionsTableTable.$converter2;
      map['budget_management'] =
          Variable<String?>(converter.mapToSql(budgetManagement));
    }
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      transactionType: Value(transactionType),
      title: Value(title),
      amount: Value(amount),
      date: Value(date),
      note: Value(note),
      icon: Value(icon),
      color: Value(color),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      subCategoryId: subCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(subCategoryId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      budgetId: budgetId == null && nullToAbsent
          ? const Value.absent()
          : Value(budgetId),
      incomeType: incomeType == null && nullToAbsent
          ? const Value.absent()
          : Value(incomeType),
      isIncomeManaged: Value(isIncomeManaged),
      budgetManagement: budgetManagement == null && nullToAbsent
          ? const Value.absent()
          : Value(budgetManagement),
    );
  }

  factory TransactionDbDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDbDto(
      id: serializer.fromJson<String>(json['id']),
      transactionType:
          serializer.fromJson<TransactionTypeTable>(json['transactionType']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String>(json['note']),
      icon: serializer.fromJson<int>(json['icon']),
      color: serializer.fromJson<int>(json['color']),
      userId: serializer.fromJson<String?>(json['userId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      subCategoryId: serializer.fromJson<String?>(json['subCategoryId']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      budgetId: serializer.fromJson<String?>(json['budgetId']),
      incomeType: serializer.fromJson<IncomeTypeTable?>(json['incomeType']),
      isIncomeManaged: serializer.fromJson<bool>(json['isIncomeManaged']),
      budgetManagement:
          serializer.fromJson<BudgetManagement?>(json['budgetManagement']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'transactionType':
          serializer.toJson<TransactionTypeTable>(transactionType),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String>(note),
      'icon': serializer.toJson<int>(icon),
      'color': serializer.toJson<int>(color),
      'userId': serializer.toJson<String?>(userId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'subCategoryId': serializer.toJson<String?>(subCategoryId),
      'accountId': serializer.toJson<String?>(accountId),
      'budgetId': serializer.toJson<String?>(budgetId),
      'incomeType': serializer.toJson<IncomeTypeTable?>(incomeType),
      'isIncomeManaged': serializer.toJson<bool>(isIncomeManaged),
      'budgetManagement':
          serializer.toJson<BudgetManagement?>(budgetManagement),
    };
  }

  TransactionDbDto copyWith(
          {String? id,
          TransactionTypeTable? transactionType,
          String? title,
          double? amount,
          DateTime? date,
          String? note,
          int? icon,
          int? color,
          String? userId,
          String? categoryId,
          String? subCategoryId,
          String? accountId,
          String? budgetId,
          IncomeTypeTable? incomeType,
          bool? isIncomeManaged,
          BudgetManagement? budgetManagement}) =>
      TransactionDbDto(
        id: id ?? this.id,
        transactionType: transactionType ?? this.transactionType,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        note: note ?? this.note,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        userId: userId ?? this.userId,
        categoryId: categoryId ?? this.categoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        accountId: accountId ?? this.accountId,
        budgetId: budgetId ?? this.budgetId,
        incomeType: incomeType ?? this.incomeType,
        isIncomeManaged: isIncomeManaged ?? this.isIncomeManaged,
        budgetManagement: budgetManagement ?? this.budgetManagement,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionDbDto(')
          ..write('id: $id, ')
          ..write('transactionType: $transactionType, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('subCategoryId: $subCategoryId, ')
          ..write('accountId: $accountId, ')
          ..write('budgetId: $budgetId, ')
          ..write('incomeType: $incomeType, ')
          ..write('isIncomeManaged: $isIncomeManaged, ')
          ..write('budgetManagement: $budgetManagement')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      transactionType,
      title,
      amount,
      date,
      note,
      icon,
      color,
      userId,
      categoryId,
      subCategoryId,
      accountId,
      budgetId,
      incomeType,
      isIncomeManaged,
      budgetManagement);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionDbDto &&
          other.id == this.id &&
          other.transactionType == this.transactionType &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.note == this.note &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.userId == this.userId &&
          other.categoryId == this.categoryId &&
          other.subCategoryId == this.subCategoryId &&
          other.accountId == this.accountId &&
          other.budgetId == this.budgetId &&
          other.incomeType == this.incomeType &&
          other.isIncomeManaged == this.isIncomeManaged &&
          other.budgetManagement == this.budgetManagement);
}

class TransactionsTableCompanion extends UpdateCompanion<TransactionDbDto> {
  final Value<String> id;
  final Value<TransactionTypeTable> transactionType;
  final Value<String> title;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String> note;
  final Value<int> icon;
  final Value<int> color;
  final Value<String?> userId;
  final Value<String?> categoryId;
  final Value<String?> subCategoryId;
  final Value<String?> accountId;
  final Value<String?> budgetId;
  final Value<IncomeTypeTable?> incomeType;
  final Value<bool> isIncomeManaged;
  final Value<BudgetManagement?> budgetManagement;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.userId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.subCategoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.budgetId = const Value.absent(),
    this.incomeType = const Value.absent(),
    this.isIncomeManaged = const Value.absent(),
    this.budgetManagement = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    required String id,
    required TransactionTypeTable transactionType,
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    required DateTime date,
    this.note = const Value.absent(),
    required int icon,
    required int color,
    this.userId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.subCategoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.budgetId = const Value.absent(),
    this.incomeType = const Value.absent(),
    this.isIncomeManaged = const Value.absent(),
    this.budgetManagement = const Value.absent(),
  })  : id = Value(id),
        transactionType = Value(transactionType),
        date = Value(date),
        icon = Value(icon),
        color = Value(color);
  static Insertable<TransactionDbDto> custom({
    Expression<String>? id,
    Expression<TransactionTypeTable>? transactionType,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<int>? icon,
    Expression<int>? color,
    Expression<String?>? userId,
    Expression<String?>? categoryId,
    Expression<String?>? subCategoryId,
    Expression<String?>? accountId,
    Expression<String?>? budgetId,
    Expression<IncomeTypeTable?>? incomeType,
    Expression<bool>? isIncomeManaged,
    Expression<BudgetManagement?>? budgetManagement,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionType != null) 'transaction_type': transactionType,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (userId != null) 'user_id': userId,
      if (categoryId != null) 'category_id': categoryId,
      if (subCategoryId != null) 'sub_category_id': subCategoryId,
      if (accountId != null) 'account_id': accountId,
      if (budgetId != null) 'budget_id': budgetId,
      if (incomeType != null) 'income_type': incomeType,
      if (isIncomeManaged != null) 'is_income_managed': isIncomeManaged,
      if (budgetManagement != null) 'budget_management': budgetManagement,
    });
  }

  TransactionsTableCompanion copyWith(
      {Value<String>? id,
      Value<TransactionTypeTable>? transactionType,
      Value<String>? title,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<String>? note,
      Value<int>? icon,
      Value<int>? color,
      Value<String?>? userId,
      Value<String?>? categoryId,
      Value<String?>? subCategoryId,
      Value<String?>? accountId,
      Value<String?>? budgetId,
      Value<IncomeTypeTable?>? incomeType,
      Value<bool>? isIncomeManaged,
      Value<BudgetManagement?>? budgetManagement}) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      transactionType: transactionType ?? this.transactionType,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      accountId: accountId ?? this.accountId,
      budgetId: budgetId ?? this.budgetId,
      incomeType: incomeType ?? this.incomeType,
      isIncomeManaged: isIncomeManaged ?? this.isIncomeManaged,
      budgetManagement: budgetManagement ?? this.budgetManagement,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (transactionType.present) {
      final converter = $TransactionsTableTable.$converter0;
      map['transaction_type'] =
          Variable<int>(converter.mapToSql(transactionType.value)!);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
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
    if (icon.present) {
      map['icon'] = Variable<int>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String?>(userId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String?>(categoryId.value);
    }
    if (subCategoryId.present) {
      map['sub_category_id'] = Variable<String?>(subCategoryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String?>(accountId.value);
    }
    if (budgetId.present) {
      map['budget_id'] = Variable<String?>(budgetId.value);
    }
    if (incomeType.present) {
      final converter = $TransactionsTableTable.$converter1;
      map['income_type'] = Variable<int?>(converter.mapToSql(incomeType.value));
    }
    if (isIncomeManaged.present) {
      map['is_income_managed'] = Variable<bool>(isIncomeManaged.value);
    }
    if (budgetManagement.present) {
      final converter = $TransactionsTableTable.$converter2;
      map['budget_management'] =
          Variable<String?>(converter.mapToSql(budgetManagement.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('transactionType: $transactionType, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('subCategoryId: $subCategoryId, ')
          ..write('accountId: $accountId, ')
          ..write('budgetId: $budgetId, ')
          ..write('incomeType: $incomeType, ')
          ..write('isIncomeManaged: $isIncomeManaged, ')
          ..write('budgetManagement: $budgetManagement')
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
  final VerificationMeta _transactionTypeMeta =
      const VerificationMeta('transactionType');
  @override
  late final GeneratedColumnWithTypeConverter<TransactionTypeTable, int?>
      transactionType = GeneratedColumn<int?>(
              'transaction_type', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<TransactionTypeTable>(
              $TransactionsTableTable.$converter0);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
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
  final VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<int?> icon = GeneratedColumn<int?>(
      'icon', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int?> color = GeneratedColumn<int?>(
      'color', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
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
  final VerificationMeta _subCategoryIdMeta =
      const VerificationMeta('subCategoryId');
  @override
  late final GeneratedColumn<String?> subCategoryId = GeneratedColumn<String?>(
      'sub_category_id', aliasedName, true,
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
          .withConverter<IncomeTypeTable?>($TransactionsTableTable.$converter1);
  final VerificationMeta _isIncomeManagedMeta =
      const VerificationMeta('isIncomeManaged');
  @override
  late final GeneratedColumn<bool?> isIncomeManaged = GeneratedColumn<bool?>(
      'is_income_managed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_income_managed IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _budgetManagementMeta =
      const VerificationMeta('budgetManagement');
  @override
  late final GeneratedColumnWithTypeConverter<BudgetManagement, String?>
      budgetManagement = GeneratedColumn<String?>(
              'budget_management', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<BudgetManagement>($TransactionsTableTable.$converter2);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        transactionType,
        title,
        amount,
        date,
        note,
        icon,
        color,
        userId,
        categoryId,
        subCategoryId,
        accountId,
        budgetId,
        incomeType,
        isIncomeManaged,
        budgetManagement
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
    context.handle(_transactionTypeMeta, const VerificationResult.success());
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
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
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
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
    if (data.containsKey('sub_category_id')) {
      context.handle(
          _subCategoryIdMeta,
          subCategoryId.isAcceptableOrUnknown(
              data['sub_category_id']!, _subCategoryIdMeta));
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
    if (data.containsKey('is_income_managed')) {
      context.handle(
          _isIncomeManagedMeta,
          isIncomeManaged.isAcceptableOrUnknown(
              data['is_income_managed']!, _isIncomeManagedMeta));
    }
    context.handle(_budgetManagementMeta, const VerificationResult.success());
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

  static TypeConverter<TransactionTypeTable, int> $converter0 =
      const EnumIndexConverter<TransactionTypeTable>(
          TransactionTypeTable.values);
  static TypeConverter<IncomeTypeTable?, int> $converter1 =
      const EnumIndexConverter<IncomeTypeTable>(IncomeTypeTable.values);
  static TypeConverter<BudgetManagement, String> $converter2 =
      const BudgetManagementConverter();
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
