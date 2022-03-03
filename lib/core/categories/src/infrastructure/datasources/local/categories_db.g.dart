// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CategoryDbDto extends DataClass implements Insertable<CategoryDbDto> {
  final String id;
  final String name;
  final int icon;
  final int color;
  final double balance;
  final CategoryTypeTable type;
  final String? userId;
  CategoryDbDto(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color,
      required this.balance,
      required this.type,
      this.userId});
  factory CategoryDbDto.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CategoryDbDto(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      icon: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}icon'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
      balance: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}balance'])!,
      type: $CategoriesTableTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<int>(icon);
    map['color'] = Variable<int>(color);
    map['balance'] = Variable<double>(balance);
    {
      final converter = $CategoriesTableTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type)!);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String?>(userId);
    }
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      color: Value(color),
      balance: Value(balance),
      type: Value(type),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory CategoryDbDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryDbDto(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<int>(json['icon']),
      color: serializer.fromJson<int>(json['color']),
      balance: serializer.fromJson<double>(json['balance']),
      type: serializer.fromJson<CategoryTypeTable>(json['type']),
      userId: serializer.fromJson<String?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<int>(icon),
      'color': serializer.toJson<int>(color),
      'balance': serializer.toJson<double>(balance),
      'type': serializer.toJson<CategoryTypeTable>(type),
      'userId': serializer.toJson<String?>(userId),
    };
  }

  CategoryDbDto copyWith(
          {String? id,
          String? name,
          int? icon,
          int? color,
          double? balance,
          CategoryTypeTable? type,
          String? userId}) =>
      CategoryDbDto(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        balance: balance ?? this.balance,
        type: type ?? this.type,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryDbDto(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('balance: $balance, ')
          ..write('type: $type, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, color, balance, type, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryDbDto &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.balance == this.balance &&
          other.type == this.type &&
          other.userId == this.userId);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoryDbDto> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> icon;
  final Value<int> color;
  final Value<double> balance;
  final Value<CategoryTypeTable> type;
  final Value<String?> userId;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.balance = const Value.absent(),
    this.type = const Value.absent(),
    this.userId = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    required String id,
    required String name,
    required int icon,
    required int color,
    this.balance = const Value.absent(),
    required CategoryTypeTable type,
    this.userId = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        icon = Value(icon),
        color = Value(color),
        type = Value(type);
  static Insertable<CategoryDbDto> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? icon,
    Expression<int>? color,
    Expression<double>? balance,
    Expression<CategoryTypeTable>? type,
    Expression<String?>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (balance != null) 'balance': balance,
      if (type != null) 'type': type,
      if (userId != null) 'user_id': userId,
    });
  }

  CategoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? icon,
      Value<int>? color,
      Value<double>? balance,
      Value<CategoryTypeTable>? type,
      Value<String?>? userId}) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      balance: balance ?? this.balance,
      type: type ?? this.type,
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
    if (icon.present) {
      map['icon'] = Variable<int>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (type.present) {
      final converter = $CategoriesTableTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value)!);
    }
    if (userId.present) {
      map['user_id'] = Variable<String?>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('balance: $balance, ')
          ..write('type: $type, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoryDbDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
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
  final VerificationMeta _balanceMeta = const VerificationMeta('balance');
  @override
  late final GeneratedColumn<double?> balance = GeneratedColumn<double?>(
      'balance', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<CategoryTypeTable, int?> type =
      GeneratedColumn<int?>('type', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<CategoryTypeTable>($CategoriesTableTable.$converter0);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'user_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, icon, color, balance, type, userId];
  @override
  String get aliasedName => _alias ?? 'categories';
  @override
  String get actualTableName => 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryDbDto> instance,
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
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryDbDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CategoryDbDto.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<CategoryTypeTable, int> $converter0 =
      const EnumIndexConverter<CategoryTypeTable>(CategoryTypeTable.values);
}

class SubCategoryDbDto extends DataClass
    implements Insertable<SubCategoryDbDto> {
  final String id;
  final String name;
  final int icon;
  final int color;
  final double balance;
  final String cateogryId;
  SubCategoryDbDto(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color,
      required this.balance,
      required this.cateogryId});
  factory SubCategoryDbDto.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SubCategoryDbDto(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      icon: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}icon'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
      balance: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}balance'])!,
      cateogryId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cateogry_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<int>(icon);
    map['color'] = Variable<int>(color);
    map['balance'] = Variable<double>(balance);
    map['cateogry_id'] = Variable<String>(cateogryId);
    return map;
  }

  SubCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return SubCategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      color: Value(color),
      balance: Value(balance),
      cateogryId: Value(cateogryId),
    );
  }

  factory SubCategoryDbDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubCategoryDbDto(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<int>(json['icon']),
      color: serializer.fromJson<int>(json['color']),
      balance: serializer.fromJson<double>(json['balance']),
      cateogryId: serializer.fromJson<String>(json['cateogryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<int>(icon),
      'color': serializer.toJson<int>(color),
      'balance': serializer.toJson<double>(balance),
      'cateogryId': serializer.toJson<String>(cateogryId),
    };
  }

  SubCategoryDbDto copyWith(
          {String? id,
          String? name,
          int? icon,
          int? color,
          double? balance,
          String? cateogryId}) =>
      SubCategoryDbDto(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        balance: balance ?? this.balance,
        cateogryId: cateogryId ?? this.cateogryId,
      );
  @override
  String toString() {
    return (StringBuffer('SubCategoryDbDto(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('balance: $balance, ')
          ..write('cateogryId: $cateogryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, color, balance, cateogryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubCategoryDbDto &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.balance == this.balance &&
          other.cateogryId == this.cateogryId);
}

class SubCategoriesTableCompanion extends UpdateCompanion<SubCategoryDbDto> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> icon;
  final Value<int> color;
  final Value<double> balance;
  final Value<String> cateogryId;
  const SubCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.balance = const Value.absent(),
    this.cateogryId = const Value.absent(),
  });
  SubCategoriesTableCompanion.insert({
    required String id,
    required String name,
    required int icon,
    required int color,
    this.balance = const Value.absent(),
    required String cateogryId,
  })  : id = Value(id),
        name = Value(name),
        icon = Value(icon),
        color = Value(color),
        cateogryId = Value(cateogryId);
  static Insertable<SubCategoryDbDto> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? icon,
    Expression<int>? color,
    Expression<double>? balance,
    Expression<String>? cateogryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (balance != null) 'balance': balance,
      if (cateogryId != null) 'cateogry_id': cateogryId,
    });
  }

  SubCategoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? icon,
      Value<int>? color,
      Value<double>? balance,
      Value<String>? cateogryId}) {
    return SubCategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      balance: balance ?? this.balance,
      cateogryId: cateogryId ?? this.cateogryId,
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
    if (icon.present) {
      map['icon'] = Variable<int>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (cateogryId.present) {
      map['cateogry_id'] = Variable<String>(cateogryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('balance: $balance, ')
          ..write('cateogryId: $cateogryId')
          ..write(')'))
        .toString();
  }
}

class $SubCategoriesTableTable extends SubCategoriesTable
    with TableInfo<$SubCategoriesTableTable, SubCategoryDbDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubCategoriesTableTable(this.attachedDatabase, [this._alias]);
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
  final VerificationMeta _balanceMeta = const VerificationMeta('balance');
  @override
  late final GeneratedColumn<double?> balance = GeneratedColumn<double?>(
      'balance', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _cateogryIdMeta = const VerificationMeta('cateogryId');
  @override
  late final GeneratedColumn<String?> cateogryId = GeneratedColumn<String?>(
      'cateogry_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES categories (id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, icon, color, balance, cateogryId];
  @override
  String get aliasedName => _alias ?? 'subcategories';
  @override
  String get actualTableName => 'subcategories';
  @override
  VerificationContext validateIntegrity(Insertable<SubCategoryDbDto> instance,
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
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    }
    if (data.containsKey('cateogry_id')) {
      context.handle(
          _cateogryIdMeta,
          cateogryId.isAcceptableOrUnknown(
              data['cateogry_id']!, _cateogryIdMeta));
    } else if (isInserting) {
      context.missing(_cateogryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubCategoryDbDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SubCategoryDbDto.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SubCategoriesTableTable createAlias(String alias) {
    return $SubCategoriesTableTable(attachedDatabase, alias);
  }
}

abstract class _$CategoriesDatabase extends GeneratedDatabase {
  _$CategoriesDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  late final $CategoriesTableTable categoriesTable =
      $CategoriesTableTable(this);
  late final $SubCategoriesTableTable subCategoriesTable =
      $SubCategoriesTableTable(this);
  late final CategoryDao categoryDao = CategoryDao(this as CategoriesDatabase);
  late final SubCategoryDao subCategoryDao =
      SubCategoryDao(this as CategoriesDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categoriesTable, subCategoriesTable];
}
