part of 'scouted_list_bloc.dart';

abstract class ScoutedListEvent extends Equatable {
  const ScoutedListEvent();

  @override
  List<Object> get props => [];
}

class GetList extends ScoutedListEvent {
  @override
  List<Object> get props => [];
}
class InitialLoad extends ScoutedListEvent {
  @override
  List<Object> get props => [];
}

class ActionScout extends ScoutedListEvent {
  final int id;
  final String madeAction;

  const ActionScout(this.id, this.madeAction);
  @override
  List<Object> get props => [id, madeAction];
  @override
  String toString() => '$madeAction Scout { id: $id}';
}