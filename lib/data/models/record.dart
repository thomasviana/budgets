import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String id;
  final String title;
  final String tag;
  final double amount;
  final Timestamp date;
  final String type;

  Transaction({
    required this.id,
    required this.title,
    required this.tag,
    required this.amount,
    required this.date,
    required this.type,
  });
}
