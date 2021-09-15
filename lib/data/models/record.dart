import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String id;
  final String title;
  final String tag;
  final double amount;
  final Timestamp date;
  final String type;

  Record({
    required this.id,
    required this.title,
    required this.tag,
    required this.amount,
    required this.date,
    required this.type,
  });
}
