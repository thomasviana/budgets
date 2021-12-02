import 'dart:io';

import 'package:budgets/domain/src/core/failures.dart';
import 'package:budgets/domain/src/core/value_objects.dart';
import 'package:budgets/domain/src/core/value_validators.dart';
import 'package:dartz/dartz.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateStringNotEmpty(input).flatMap(
        validateEmailAddress,
      ),
    );
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(
      validateStringNotEmpty(input).flatMap(
        validatePasswordSecurity,
      ),
    );
  }

  const Password._(this.value);
}

class UserName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 30;

  factory UserName(String input) {
    return UserName._(
      validateMaxStringLength(input, maxLength)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateSingleLine),
    );
  }

  const UserName._(this.value);
}

class PhoneNumber extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PhoneNumber(String input) {
    return PhoneNumber._(
      validatePhoneNumber(input),
    );
  }

  const PhoneNumber._(this.value);
}

class UserImage extends ValueObject<File> {
  @override
  final Either<ValueFailure<File>, File> value;

  factory UserImage(File input) {
    return UserImage._(
      right(input),
    );
  }

  const UserImage._(this.value);
}
