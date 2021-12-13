import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class CategoryName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 20;

  factory CategoryName(String input) {
    return CategoryName._(
      validateMaxStringLength(input, maxLength)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateSingleLine),
    );
  }

  const CategoryName._(this.value);
}

class CategoryColor extends ValueObject<Color> {
  static const List<Color> predefinedColors = [
    Colors.red,
    Colors.lightBlueAccent,
    Colors.amber,
    Colors.grey,
    Colors.purple,
    Colors.lightGreenAccent,
    Colors.deepPurple,
    Colors.teal,
    Colors.pink,
    Colors.yellowAccent
  ];

  @override
  final Either<ValueFailure<Color>, Color> value;

  factory CategoryColor(Color input) {
    return CategoryColor._(
      right(input),
    );
  }

  const CategoryColor._(this.value);
}
