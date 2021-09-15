part of 'record_cubit.dart';

abstract class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

class RecordInitialState extends RecordState {}

class RecordLoadingState extends RecordState {}

class RecordReadyState extends RecordState {
  final List<Record> recordList;

  RecordReadyState(this.recordList);
}

class RecordAddedState extends RecordState {
  final String userId;
  final Record record;

  const RecordAddedState(this.userId, this.record);

  @override
  List<Object> get props => [record];
}

class RecordDeletedState extends RecordState {
  final String userId;

  final String id;

  const RecordDeletedState(this.userId, this.id);

  @override
  List<Object> get props => [id];
}
