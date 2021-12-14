import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../presentation/resources/colors.dart';
import '../../categories.dart';
import '../../core.dart';
import 'sub_category.dart';

class Category {
  final String id;
  final CategoryName? name;
  final Icon? icon;
  final CategoryColor? color;
  final double? totalAmount;
  final List<SubCategory> subCategories;
  Category({
    required this.id,
    this.name,
    this.icon,
    this.color,
    this.totalAmount,
    required this.subCategories,
  });

  factory Category.housing() => Category(
        id: Uuid().v1(),
        name: CategoryName('Vivienda'),
        icon: Icon(
          Icons.home,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.amber),
        totalAmount: 0.0,
        subCategories: SubCategory.defaultHousingSubCategories,
      );

  factory Category.food() => Category(
        id: Uuid().v1(),
        name: CategoryName('Alimentación'),
        icon: Icon(
          Icons.food_bank,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.red),
        totalAmount: 0.0,
        subCategories: SubCategory.defaultFoodSubCategories,
      );

  factory Category.transportation() => Category(
        id: Uuid().v1(),
        name: CategoryName('Transporte'),
        icon: Icon(
          Icons.car_repair,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.grey),
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.healthCare() => Category(
        id: Uuid().v1(),
        name: CategoryName('Salud'),
        icon: Icon(
          Icons.local_hospital,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.lightGreenAccent),
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.services() => Category(
        id: Uuid().v1(),
        name: CategoryName('Servicios'),
        icon: Icon(
          Icons.wifi,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.purple),
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.recreation() => Category(
        id: Uuid().v1(),
        name: CategoryName('Recreación'),
        icon: Icon(
          Icons.restaurant,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.pink),
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.shopping() => Category(
        id: Uuid().v1(),
        name: CategoryName('Compras'),
        icon: Icon(
          Icons.shopping_bag_outlined,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.lightBlueAccent),
        totalAmount: 0.0,
        subCategories: [],
      );

  factory Category.financial() => Category(
        id: Uuid().v1(),
        name: CategoryName('Gastos financieros'),
        icon: Icon(
          Icons.money_off,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.teal),
        totalAmount: 0.0,
        subCategories: [],
      );

  static List<Category> get defaultCategories {
    return [
      Category.housing(),
      Category.food(),
      Category.transportation(),
      Category.healthCare(),
      Category.services(),
      Category.recreation(),
      Category.shopping(),
      Category.financial(),
    ];
  }

  Option<ValueFailure<dynamic>> get failureOption {
    return name!.value.fold(
      (f) => some(f),
      (_) => none(),
    );
  }

  Category copyWith({
    String? id,
    CategoryName? name,
    Icon? icon,
    CategoryColor? color,
    double? totalAmount,
    List<SubCategory>? subCategories,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      totalAmount: totalAmount ?? this.totalAmount,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}
