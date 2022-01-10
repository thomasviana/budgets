// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budgets_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class BudgetDbDto extends DataClass implements Insertable<BudgetDbDto> {
  final String id;
  final String name;
  final String? abbreviation;
  final int color;
  final double balance;
  final String? userId;
  BudgetDbDto(
      {required this.id,
      required this.name,
      this.abbreviation,
      required this.color,
      required this.balance,
      this.userId});
  factory BudgetDbDto.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return BudgetDbDto(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      abbreviation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}abbreviation']),
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
      balance: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}balance'])!,
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || abbreviation != null) {
      map['abbreviation'] = Variable<String?>(abbreviation);
    }
    map['color'] = Variable<int>(color);
    map['balance'] = Variable<double>(balance);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String?>(userId);
    }
    return map;
  }

  BudgetsTableCompanion toCompanion(bool nullToAbsent) {
    return BudgetsTableCompanion(
      id: Value(id),
      name: Value(name),
      abbreviation: abbreviation == null && nullToAbsent
          ? const Value.absent()
          : Value(abbreviation),
      color: Value(color),
      balance: Value(balance),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory BudgetDbDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetDbDto(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      abbreviation: serializer.fromJson<String?>(json['abbreviation']),
      color: serializer.fromJson<int>(json['color']),
      balance: serializer.fromJson<double>(json['balance']),
      userId: serializer.fromJson<String?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'abbreviation': serializer.toJson<String?>(abbreviation),
      'color': serializer.toJson<int>(color),
      'balance': serializer.toJson<double>(balance),
      'userId': serializer.toJson<String?>(userId),
    };
  }

  BudgetDbDto copyWith(
          {String? id,
          String? name,
          String? abbreviation,
          int? color,
          double? balance,
          String? userId}) =>
      BudgetDbDto(
        id: id ?? this.id,
        name: name ?? this.name,
        abbreviation: abbreviation ?? this.abbreviation,
        color: color ?? this.color,
        balance: balance ?? this.balance,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('BudgetDbDto(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('color: $color, ')
          ..write('balance: $balance, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, abbreviation, color, balance, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetDbDto &&
          other.id == this.id &&
          other.name == this.name &&
          other.abbreviation == this.abbreviation &&
          other.color == this.color &&
          other.balance == this.balance &&
          other.userId == this.userId);
}

class BudgetsTableCompanion extends UpdateCompanion<BudgetDbDto> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> abbreviation;
  final Value<int> color;
  final Value<double> balance;
  final Value<String?> userId;
  const BudgetsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.abbreviation = const Value.absent(),
    this.color = const Value.absent(),
    this.balance = const Value.absent(),
    this.userId = const Value.absent(),
  });
  BudgetsTableCompanion.insert({
    required String id,
    required String name,
    this.abbreviation = const Value.absent(),
    required int color,
    this.balance = const Value.absent(),
    this.userId = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        color = Value(color);
  static Insertable<BudgetDbDto> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String?>? abbreviation,
    Expression<int>? color,
    Expression<double>? balance,
    Expression<String?>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (abbreviation != null) 'abbreviation': abbreviation,
      if (color != null) 'color': color,
      if (balance != null) 'balance': balance,
      if (userId != null) 'user_id': userId,
    });
  }

  BudgetsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? abbreviation,
      Value<int>? color,
      Value<double>? balance,
      Value<String?>? userId}) {
    return BudgetsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      abbreviation: abbreviation ?? this.abbreviation,
      color: color ?? this.color,
      balance: balance ?? this.balance,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (abbreviation.present) {
      map['abbreviation'] = Variable<String?>(abbreviation.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String?>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('color: $color, ')
          ..write('balance: $balance, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTableTable extends BudgetsTable
    with TableInfo<$BudgetsTableTable, BudgetDbDto> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BudgetsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _abbreviationMeta =
      const VerificationMeta('abbreviation');
  @override
  late final GeneratedColumn<String?> abbreviation = GeneratedColumn<String?>(
      'abbreviation', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int?> color = GeneratedColumn<int?>(
      'color', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _balanceMeta = const VerificationMeta('balance');
  @override
  late final GeneratedColumn<double?> balance = GeneratedColumn<double?>(
      'balance', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'user_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, abbreviation, color, balance, userId];
  @override
  String get aliasedName => _alias ?? 'budgets';
  @override
  String get actualTableName => 'budgets';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetDbDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('abbreviation')) {
      context.handle(
          _abbreviationMeta,
          abbreviation.isAcceptableOrUnknown(
              data['abbreviation']!, _abbreviationMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetDbDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return BudgetDbDto.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BudgetsTableTable createAlias(String alias) {
    return $BudgetsTableTable(_db, alias);
  }
}

abstract class _$BudgetsDatabase extends GeneratedDatabase {
  _$BudgetsDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $BudgetsTableTable budgetsTable = $BudgetsTableTable(this);
  late final BudgetDao budgetDao = BudgetDao(this as BudgetsDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [budgetsTable];
}
