import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Record extends Equatable {
  final String id;
  final String title;
  final String tag;
  final double amount;
  final Timestamp date;
  final String type;

  const Record({
    required this.id,
    required this.title,
    required this.tag,
    required this.amount,
    required this.date,
    required this.type,
  });

  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'title': title,
      'tag': tag,
      'amount': amount,
      'date': date,
      'type': type,
    };
  }

  Record.fromFirebaseMap(Map<String?, Object?> data)
      : id = data['id']! as String,
        title = data['title']! as String,
        tag = data['tag']! as String,
        amount = data['amount']! as double,
        date = data['date']! as Timestamp,
        type = data['type']! as String;
}
