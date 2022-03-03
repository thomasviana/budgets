// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AccountDbDto extends DataClass implements Insertable<AccountDbDto> {
  final String id;
  final String name;
  final AccountTypeTable type;
  final int color;
  final String? imageUrl;
  final double balance;
  final String? userId;
  AccountDbDto(
      {required this.id,
      required this.name,
      required this.type,
      required this.color,
      this.imageUrl,
      required this.balance,
      this.userId});
  factory AccountDbDto.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AccountDbDto(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      type: $AccountsTableTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
      imageUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_url']),
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
    {
      final converter = $AccountsTableTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type)!);
    }
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String?>(imageUrl);
    }
    map['balance'] = Variable<double>(balance);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String?>(userId);
    }
    return map;
  }

  AccountsTableCompanion toCompanion(bool nullToAbsent) {
    return AccountsTableCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      color: Value(color),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      balance: Value(balance),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory AccountDbDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountDbDto(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<AccountTypeTable>(json['type']),
      color: serializer.fromJson<int>(json['color']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
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
      'type': serializer.toJson<AccountTypeTable>(type),
      'color': serializer.toJson<int>(color),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'balance': serializer.toJson<double>(balance),
      'userId': serializer.toJson<String?>(userId),
    };
  }

  AccountDbDto copyWith(
          {String? id,
          String? name,
          AccountTypeTable? type,
          int? color,
          String? imageUrl,
          double? balance,
          String? userId}) =>
      AccountDbDto(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        color: color ?? this.color,
        imageUrl: imageUrl ?? this.imageUrl,
        balance: balance ?? this.balance,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('AccountDbDto(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('color: $color, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('balance: $balance, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, color, imageUrl, balance, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountDbDto &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.color == this.color &&
          other.imageUrl == this.imageUrl &&
          other.balance == this.balance &&
          other.userId == this.userId);
}

class AccountsTableCompanion extends UpdateCompanion<AccountDbDto> {
  final Value<String> id;
  final Value<String> name;
  final Value<AccountTypeTable> type;
  final Value<int> color;
  final Value<String?> imageUrl;
  final Value<double> balance;
  final Value<String?> userId;
  const AccountsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.color = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.balance = const Value.absent(),
    this.userId = const Value.absent(),
  });
  AccountsTableCompanion.insert({
    required String id,
    required String name,
    required AccountTypeTable type,
    required int color,
    this.imageUrl = const Value.absent(),
    this.balance = const Value.absent(),
    this.userId = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        color = Value(color);
  static Insertable<AccountDbDto> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<AccountTypeTable>? type,
    Expression<int>? color,
    Expression<String?>? imageUrl,
    Expression<double>? balance,
    Expression<String?>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (color != null) 'color': color,
      if (imageUrl != null) 'image_url': imageUrl,
      if (balance != null) 'balance': balance,
      if (userId != null) 'user_id': userId,
    });
  }

  AccountsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<AccountTypeTable>? type,
      Value<int>? color,
      Value<String?>? imageUrl,
      Value<double>? balance,
      Value<String?>? userId}) {
    return AccountsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      color: color ?? this.color,
      imageUrl: imageUrl ?? this.imageUrl,
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
    if (type.present) {
      final converter = $AccountsTableTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value)!);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String?>(imageUrl.value);
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
    return (StringBuffer('AccountsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('color: $color, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('balance: $balance, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $AccountsTableTable extends AccountsTable
    with TableInfo<$AccountsTableTable, AccountDbDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTableTable(this.attachedDatabase, [this._alias]);
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
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<AccountTypeTable, int?> type =
      GeneratedColumn<int?>('type', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<AccountTypeTable>($AccountsTableTable.$converter0);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int?> color = GeneratedColumn<int?>(
      'color', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String?> imageUrl = GeneratedColumn<String?>(
      'image_url', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
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
      [id, name, type, color, imageUrl, balance, userId];
  @override
  String get aliasedName => _alias ?? 'accounts';
  @override
  String get actualTableName => 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<AccountDbDto> instance,
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
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
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
  AccountDbDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AccountDbDto.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AccountsTableTable createAlias(String alias) {
    return $AccountsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountTypeTable, int> $converter0 =
      const EnumIndexConverter<AccountTypeTable>(AccountTypeTable.values);
}

abstract class _$AccountsDatabase extends GeneratedDatabase {
  _$AccountsDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AccountsTableTable accountsTable = $AccountsTableTable(this);
  late final AccountDao accountDao = AccountDao(this as AccountsDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [accountsTable];
}
