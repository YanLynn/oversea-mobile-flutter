part of 'jobappliedlist_bloc.dart';

abstract class JobappliedlistEvent extends Equatable {
  const JobappliedlistEvent();

  @override
  List<Object> get props => [];
}

class Getjobappliedlist extends JobappliedlistEvent {
  @override
  List<Object> get props => null;
}
//changestatus
class Getjobstatus extends JobappliedlistEvent {
  final String applyid;

  Getjobstatus(this.applyid);

  @override
  List<Object> get props => null;
}
