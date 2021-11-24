import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/records.dart';

class RecordFirebaseProvider {
  final _fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> init() {
    return _fireStore.collection('CRUD').snapshots();
  }

  Future<void> addRecord(String userId, Record record) async {
    await _fireStore
        .collection('users/$userId/transactions')
        .add(record.toFirebaseMap());
  }

  Future<void> deleteRecord(String userId, String id) async {
    await _fireStore.collection('users/$userId/transactions').doc(id).delete();
  }

  Future<List<Record>> getRecords(String userId) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users/$userId/transactions')
        .orderBy('date')
        .get();
    final allData = querySnapshot.docs;

    final List<Record> recordsList = [];
    for (final record in allData) {
      final recordId = record.id;
      final recordTitle = record['title'] as String;
      final recordTag = record['tag'] as String;
      final recordAmount = record['amount'] as double;
      final recordDate = record['date'] as Timestamp;
      final recordType = record['type'] as String;

      final newRecord = Record(
        id: recordId,
        title: recordTitle,
        tag: recordTag,
        amount: recordAmount.toDouble(),
        date: recordDate,
        type: recordType,
      );
      recordsList.add(newRecord);
    }
    return recordsList;
  }
}
