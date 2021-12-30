import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = ExceedingLength<T>;
  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;
  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = InvalidEmail<T>;
  const factory ValueFailure.shortPassword({
    required String failedValue,
  }) = ShortPassword<T>;
  const factory ValueFailure.passwordDoNotMatch({
    required String failedValue,
  }) = PasswordDoNotMatch<T>;
  const factory ValueFailure.multiLine({
    required T failedValue,
  }) = MultiLine<T>;
  const factory ValueFailure.listToLong({
    required T failedValue,
    required int max,
  }) = ListToLong<T>;
  const factory ValueFailure.invalidUserName({
    required String failedValue,
  }) = InvalidUserName<T>;
  const factory ValueFailure.invalidPhoneNumber({
    required String failedValue,
  }) = InvalidPhoneNumber<T>;
}
