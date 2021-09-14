import 'package:budgets/data/models/record.dart';
import 'package:budgets/data/providers/record_firebase_provider.dart';
import 'package:budgets/data/repository/record_repository.dart';

class RecordRepository extends RecordRepositoryBase {
  final provider = RecordFirebaseProvider();
  @override
  Future<void> addRecord(Record record) async {
    provider.addRecord(record);
  }

  @override
  Future<void> deleteRecord(String id) async {
    provider.deleteRecord(id);
  }

  @override
  Future<List<Record?>> getRecords() {
    // TODO: implement getRecords
    throw UnimplementedError();
  }
}
