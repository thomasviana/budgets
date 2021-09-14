import 'package:bloc/bloc.dart';
import 'package:budgets/data/models/record.dart';
import 'package:budgets/data/repository/record_repository.dart';
import 'package:equatable/equatable.dart';

part 'record_state.dart';

class RecordCubit extends Cubit<RecordState> {
  final RecordRepositoryBase _recordRepository;

  RecordCubit(this._recordRepository) : super(RecordInitialState());

  Future<void> getRecords(String userId) async {
    emit(RecordLoadingState());
    await _recordRepository.getRecords(userId);
    emit(RecordReadyState());
  }

  Future<void> addRecord(String userId, Record record) async {
    emit(RecordLoadingState());
    await _recordRepository.addRecord(userId, record);
    emit(RecordAddedState(userId, record));
  }

  Future<void> deleteRecord(String userId, String id) async {
    emit(RecordLoadingState());
    await _recordRepository.deleteRecord(userId, id);
    emit(RecordDeletedState(userId, id));
  }
}
