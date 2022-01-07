import '../../../../../common/value_objects.dart';
import 'value_validators.dart';

class EmailAddress extends SingleValueObject<String> {
  const EmailAddress(String value) : super(value);

  bool get isValid => validateEmailAddress(value);
}

class Password extends SingleValueObject<String> {
  const Password(String value) : super(value);

  bool get isSecure => validatePasswordSecurity(value);
}

class UserName extends SingleValueObject<String> {
  const UserName(String value) : super(value);

  bool get isSecure => validateUserName(value);
}

class PhoneNumber extends SingleValueObject<String> {
  const PhoneNumber(String value) : super(value);

  bool get isSecure => validatePhoneNumber(value);
}
