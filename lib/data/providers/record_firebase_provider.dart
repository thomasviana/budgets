import 'package:budgets/data/models/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RecordFirebaseProvider {
  Future<void> addRecord(String userId, Record record) async {
    FirebaseFirestore.instance.collection('users/$userId/transactions').add(
      {
        'id': record.id,
        'title': record.title,
        'tag': record.tag,
        'amount': record.amount,
        'date': record.date,
        'type': record.type,
      },
    );
  }

  Future<void> deleteRecord(String userId, String id) async {
    await FirebaseFirestore.instance
        .collection('users/$userId/transactions')
        .doc(id)
        .delete();
  }

  Future<List<Record>> getRecords(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users/$userId/transactions')
        .orderBy('date')
        .get();
    final allData = querySnapshot.docs;

    List<Record> recordsList = [];
    for (var tx in allData) {
      final txTitle = tx['title'];
      final txTag = tx['tag'];
      final txAmount = tx['amount'];
      final txDate = tx['date'];
      final txId = tx['id'];
      final txType = tx['type'];

      final newRecord = Record(
        id: txId,
        title: txTitle,
        tag: txTag,
        amount: txAmount,
        date: txDate,
        type: txType,
      );
      recordsList.add(newRecord);
    }
    print(recordsList);
    return recordsList;
  }
}
