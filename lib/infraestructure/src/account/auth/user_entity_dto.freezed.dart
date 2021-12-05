// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_entity_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserEntityDTOTearOff {
  const _$UserEntityDTOTearOff();

  _UserEntityDTO call(
      {required String? id,
      required String? name,
      required String? emailAddress,
      required String? phoneNumber,
      required String? photoUrl}) {
    return _UserEntityDTO(
      id: id,
      name: name,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
    );
  }
}

/// @nodoc
const $UserEntityDTO = _$UserEntityDTOTearOff();

/// @nodoc
mixin _$UserEntityDTO {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get emailAddress => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserEntityDTOCopyWith<UserEntityDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEntityDTOCopyWith<$Res> {
  factory $UserEntityDTOCopyWith(
          UserEntityDTO value, $Res Function(UserEntityDTO) then) =
      _$UserEntityDTOCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? name,
      String? emailAddress,
      String? phoneNumber,
      String? photoUrl});
}

/// @nodoc
class _$UserEntityDTOCopyWithImpl<$Res>
    implements $UserEntityDTOCopyWith<$Res> {
  _$UserEntityDTOCopyWithImpl(this._value, this._then);

  final UserEntityDTO _value;
  // ignore: unused_field
  final $Res Function(UserEntityDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? emailAddress = freezed,
    Object? phoneNumber = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$UserEntityDTOCopyWith<$Res>
    implements $UserEntityDTOCopyWith<$Res> {
  factory _$UserEntityDTOCopyWith(
          _UserEntityDTO value, $Res Function(_UserEntityDTO) then) =
      __$UserEntityDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? name,
      String? emailAddress,
      String? phoneNumber,
      String? photoUrl});
}

/// @nodoc
class __$UserEntityDTOCopyWithImpl<$Res>
    extends _$UserEntityDTOCopyWithImpl<$Res>
    implements _$UserEntityDTOCopyWith<$Res> {
  __$UserEntityDTOCopyWithImpl(
      _UserEntityDTO _value, $Res Function(_UserEntityDTO) _then)
      : super(_value, (v) => _then(v as _UserEntityDTO));

  @override
  _UserEntityDTO get _value => super._value as _UserEntityDTO;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? emailAddress = freezed,
    Object? phoneNumber = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_UserEntityDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_UserEntityDTO extends _UserEntityDTO {
  const _$_UserEntityDTO(
      {required this.id,
      required this.name,
      required this.emailAddress,
      required this.phoneNumber,
      required this.photoUrl})
      : super._();

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? emailAddress;
  @override
  final String? phoneNumber;
  @override
  final String? photoUrl;

  @override
  String toString() {
    return 'UserEntityDTO(id: $id, name: $name, emailAddress: $emailAddress, phoneNumber: $phoneNumber, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserEntityDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, emailAddress, phoneNumber, photoUrl);

  @JsonKey(ignore: true)
  @override
  _$UserEntityDTOCopyWith<_UserEntityDTO> get copyWith =>
      __$UserEntityDTOCopyWithImpl<_UserEntityDTO>(this, _$identity);
}

abstract class _UserEntityDTO extends UserEntityDTO {
  const factory _UserEntityDTO(
      {required String? id,
      required String? name,
      required String? emailAddress,
      required String? phoneNumber,
      required String? photoUrl}) = _$_UserEntityDTO;
  const _UserEntityDTO._() : super._();

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get emailAddress;
  @override
  String? get phoneNumber;
  @override
  String? get photoUrl;
  @override
  @JsonKey(ignore: true)
  _$UserEntityDTOCopyWith<_UserEntityDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
