import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';

class CategoryModel extends Entity<CategoryId> {
  String name;
  int icon;
  int color;
  double balance = 0;

  CategoryModel({
    required CategoryId id,
    required this.name,
    required this.icon,
    required this.color,
    required this.balance,
  }) : super(id);
}

class CategoryId extends AlphanumericId {
  const CategoryId(String value) : super(value);

  CategoryId.auto() : this(const Uuid().v1());
}
