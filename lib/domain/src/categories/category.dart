import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../categories.dart';
import '../../core.dart';

class Category {
  final CategoryName? name;
  final Icon? icon;
  final CategoryColor? color;
  final double? totalAmount;
  Category({
    this.name,
    this.icon,
    this.color,
    this.totalAmount,
  });

  factory Category.home() => Category(
        name: CategoryName('Vivienda'),
        icon: Icon(Icons.home),
        color: CategoryColor(Colors.amber),
        totalAmount: 0.0,
      );

  factory Category.food() => Category(
        name: CategoryName('Alimentación'),
        icon: Icon(Icons.food_bank),
        color: CategoryColor(Colors.red),
        totalAmount: 0.0,
      );

  factory Category.transportation() => Category(
        name: CategoryName('Transporte'),
        icon: Icon(Icons.car_rental),
        color: CategoryColor(Colors.grey),
        totalAmount: 0.0,
      );

  factory Category.health() => Category(
        name: CategoryName('Salud'),
        icon: Icon(Icons.healing),
        color: CategoryColor(Colors.green),
        totalAmount: 0.0,
      );

  factory Category.services() => Category(
        name: CategoryName('Servicios'),
        icon: Icon(Icons.car_rental),
        color: CategoryColor(Colors.grey),
        totalAmount: 0.0,
      );

  factory Category.recreation() => Category(
        name: CategoryName('Salidas'),
        icon: Icon(Icons.restaurant),
        color: CategoryColor(Colors.grey),
        totalAmount: 0.0,
      );

  factory Category.shopping() => Category(
        name: CategoryName('Compras'),
        icon: Icon(Icons.shopping_bag),
        color: CategoryColor(Colors.grey),
        totalAmount: 0.0,
      );

  static List<Category> get defaultCategories {
    return [
      Category.home(),
      Category.food(),
      Category.transportation(),
      Category.health(),
      Category.services(),
      Category.recreation(),
      Category.shopping(),
    ];
  }

  Option<ValueFailure<dynamic>> get failureOption {
    return name!.value.fold(
      (f) => some(f),
      (_) => none(),
    );
  }

  Category copyWith({
    CategoryName? name,
    Icon? icon,
    CategoryColor? color,
    double? totalAmount,
  }) {
    return Category(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
