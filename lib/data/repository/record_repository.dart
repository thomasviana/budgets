import '../models/record.dart';

abstract class RecordRepositoryBase {
  Future<List<Record>> getRecords(String userId);
  Future<void> addRecord(String userId, Record record);
  Future<void> deleteRecord(String userId, String id);
}
