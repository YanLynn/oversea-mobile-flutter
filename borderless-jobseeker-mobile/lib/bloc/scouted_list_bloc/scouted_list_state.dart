part of 'scouted_list_bloc.dart';

abstract class ScoutedListState extends Equatable {
  const ScoutedListState();
  
  @override
  List<Object> get props => [];
}

class ScoutedListInitial extends ScoutedListState {}

class ScoutedListLoading extends ScoutedListState {}
class ActionLoading extends ScoutedListState {}

class ScoutedListSuccess extends ScoutedListState {
  final scoutedList;

  ScoutedListSuccess(this.scoutedList);

  @override
  List<Object> get props => [scoutedList];
}

class ScoutedListFailure extends ScoutedListState {
  final error;

  ScoutedListFailure(this.error);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Scouted List { error: $error }'; 
}