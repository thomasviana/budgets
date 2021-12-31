import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';

class CategoryModel extends Entity<CategoryId> {
  CategoryUserId? categoryUserId;
  String name;
  int icon;
  int color;

  CategoryModel({
    required CategoryId id,
    required this.name,
    required this.icon,
    required this.color,
    this.categoryUserId,
  }) : super(id);

// ignore: use_setters_to_change_properties
  void updateName(String newName) => name = newName;
  // ignore: use_setters_to_change_properties
  void updateIcon(int newIcon) => icon = newIcon;
  // ignore: use_setters_to_change_properties
  void updateColor(int newColor) => color = newColor;
}

class CategoryId extends AlphanumericId {
  const CategoryId(String value) : super(value);

  CategoryId.auto() : this(const Uuid().v1());
}

class CategoryUserId extends AlphanumericId {
  const CategoryUserId(String value) : super(value);

  CategoryUserId.auto() : this(const Uuid().v1());
}
