part of 'scoutdetails_bloc.dart';

abstract class ScoutdetailsState extends Equatable {
  const ScoutdetailsState();

  @override
  List<Object> get props => [];
}

class ScoutdetailsInitial extends ScoutdetailsState {
  const ScoutdetailsInitial();
  @override
  List<Object> get props => [];
}
class Scoutdetailsloading extends ScoutdetailsState{}
class Getscoutdetailssuccess extends ScoutdetailsState {
  final List scoutlist;

  const Getscoutdetailssuccess(this.scoutlist);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [scoutlist];
}
class Scoutremovesuccess extends ScoutdetailsState {
  final scoutlist;

  const Scoutremovesuccess(this.scoutlist);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [scoutlist];
}
class Scoutsuccess extends ScoutdetailsState {
  final scoutedList;

  Scoutsuccess(this.scoutedList);

  @override
  List<Object> get props => [scoutedList];
}

class Getscoutdetailsfails extends ScoutdetailsState {
  final String error;
  Getscoutdetailsfails(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}
