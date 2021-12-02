import 'failures.dart';

class NotAuthenticatedError extends Error {}

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() =>
      Error.safeToString('UnexpectedValueError(valueFailure: $valueFailure)');
}
