import 'package:flutter/material.dart';

class Transaction {
  String id;
  String title;
  String budget;
  double amount;
  DateTime date;
  String type;

  Transaction({
    required this.id,
    required this.title,
    required this.budget,
    required this.amount,
    required this.date,
    required this.type,
  });
}
