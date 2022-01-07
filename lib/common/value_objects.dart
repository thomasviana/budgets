import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class ValueObject {}

abstract class SingleValueObject<T extends Object> implements ValueObject {
  const SingleValueObject(this.value);

  final T value;

  @override
  String toString() {
    return 'SingleValueObject{value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SingleValueObject &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

abstract class Entity<T extends ValueObject> {
  const Entity(this.id);

  final T id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

abstract class AlphanumericId extends SingleValueObject<String>
    implements Comparable<AlphanumericId> {
  const AlphanumericId(String value) : super(value);

  bool get isValid => value.isNotEmpty;

  @override
  String toString() => value;

  @override
  int compareTo(AlphanumericId other) => value.compareTo(other.value);
}
