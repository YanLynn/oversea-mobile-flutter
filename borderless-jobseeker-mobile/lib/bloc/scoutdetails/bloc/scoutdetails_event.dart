part of 'scoutdetails_bloc.dart';

abstract class ScoutdetailsEvent extends Equatable {
  const ScoutdetailsEvent();

  @override
  List<Object> get props => [];
}

class Getscoutdetails extends ScoutdetailsEvent {
  final String scoutid;

  Getscoutdetails(this.scoutid);
  @override
  List<Object> get props => null;
}
class ActiondetailsScout extends ScoutdetailsEvent {
  final int id;
  final String madeAction;

  const ActiondetailsScout(this.id, this.madeAction);
  @override
  List<Object> get props => [id, madeAction];
  @override
  String toString() => '$madeAction Scout { id: $id}';
}
