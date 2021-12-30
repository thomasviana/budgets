import 'package:dartz/dartz.dart';

import '../../../../../common/failures.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLenght,
) {
  if (input.length <= maxLenght) {
    return right(input);
  } else {
    return left(
      ValueFailure.exceedingLength(failedValue: input, max: maxLenght),
    );
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (!input.contains('\n')) {
    return right(input);
  } else {
    return left(
      ValueFailure.multiLine(
        failedValue: input,
      ),
    );
  }
}

bool validateEmailAddress(String input) {
  const emailRegex = r'(^[\w\._+-]{1,}(\+[\w]{1,})?@[\w\.\-]{3,}.\w{2,5}$)';
  if (RegExp(emailRegex).hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}

bool validatePasswordSecurity(String input) {
  if (input.length >= 6) {
    return true;
  } else {
    return false;
  }
}

bool validatePasswordMatch(
  String password,
  String confirmation,
) {
  if (password == confirmation) {
    return true;
  } else {
    return false;
  }
}

bool validateUserName(String input) {
  const nameRegex = '^[a-zA-Z]+';
  if (RegExp(nameRegex).hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}

bool validatePhoneNumber(String input) {
  const nameRegex =
      r'^(([0]\d{1,2})?[\s.-]?[+-0]\d{1,3})?[\s.-]?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$';
  if (RegExp(nameRegex).hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}
