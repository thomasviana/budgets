import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../presentation/resources/colors.dart';
import '../../categories.dart';
import '../../core.dart';

class SubCategory {
  final String? id;
  final CategoryName? name;
  final Icon? icon;
  final CategoryColor? color;
  final double? totalAmount;
  SubCategory({
    this.id,
    this.name,
    this.icon,
    this.color,
    this.totalAmount,
  });

  factory SubCategory.rent() => SubCategory(
        id: Uuid().v1(),
        name: CategoryName('Arriendo'),
        icon: Icon(
          Icons.home,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.amber),
        totalAmount: 0.0,
      );

  factory SubCategory.morgage() => SubCategory(
        id: Uuid().v1(),
        name: CategoryName('Hipoteca'),
        icon: Icon(
          Icons.home,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.amber),
        totalAmount: 0.0,
      );

  factory SubCategory.services() => SubCategory(
        id: Uuid().v1(),
        name: CategoryName('Servicios Públicos'),
        icon: Icon(
          Icons.home,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.amber),
        totalAmount: 0.0,
      );

  factory SubCategory.meats() => SubCategory(
        id: Uuid().v1(),
        name: CategoryName('Carnes'),
        icon: Icon(
          Icons.food_bank,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.red),
        totalAmount: 0.0,
      );
  factory SubCategory.fruitsAndVegetables() => SubCategory(
        id: Uuid().v1(),
        name: CategoryName('Frutas y verduras'),
        icon: Icon(
          Icons.food_bank,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.red),
        totalAmount: 0.0,
      );
  factory SubCategory.miscellaneous() => SubCategory(
        id: Uuid().v1(),
        name: CategoryName('Miscelaneos'),
        icon: Icon(
          Icons.food_bank,
          color: AppColors.white,
        ),
        color: CategoryColor(Colors.red),
        totalAmount: 0.0,
      );

  static List<SubCategory> get defaultHousingSubCategories {
    return [
      SubCategory.rent(),
      SubCategory.morgage(),
      SubCategory.services(),
    ];
  }

  static List<SubCategory> get defaultFoodSubCategories {
    return [
      SubCategory.meats(),
      SubCategory.fruitsAndVegetables(),
      SubCategory.miscellaneous(),
    ];
  }

  Option<ValueFailure<dynamic>> get failureOption {
    return name!.value.fold(
      (f) => some(f),
      (_) => none(),
    );
  }

  SubCategory copyWith({
    String? id,
    CategoryName? name,
    Icon? icon,
    CategoryColor? color,
    double? totalAmount,
  }) {
    return SubCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
