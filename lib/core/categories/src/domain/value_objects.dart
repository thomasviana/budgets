import '../../../../common/value_objects.dart';

class CategoryName extends SingleValueObject<String> {
  const CategoryName(String value) : super(value);

  bool get isValid => value.isNotEmpty;
}
