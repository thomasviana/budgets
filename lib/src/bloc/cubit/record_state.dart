part of 'record_cubit.dart';

abstract class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

class RecordInitialState extends RecordState {}

class RecordLoadingState extends RecordState {}

class RecordReadyState extends RecordState {}

class RecordAddedState extends RecordState {
  final String userId;
  final Record record;

  RecordAddedState(this.record, this.userId);

  @override
  List<Object> get props => [record];
}

class RecordDeletedState extends RecordState {
  final String userId;

  final String id;

  RecordDeletedState(this.id, this.userId);

  @override
  List<Object> get props => [id];
}
