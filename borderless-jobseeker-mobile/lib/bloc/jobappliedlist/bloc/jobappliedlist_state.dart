part of 'jobappliedlist_bloc.dart';

abstract class JobappliedlistState extends Equatable {
  const JobappliedlistState();
  
  @override
  List<Object> get props => [];
}

class JobappliedlistInitial extends JobappliedlistState {
  const JobappliedlistInitial();
  @override
  List<Object> get props => [];
}
class ChangestatusInitial  extends JobappliedlistState {
  const ChangestatusInitial();
  @override
  List<Object> get props => [];
}
class Jobgetsuccess extends JobappliedlistState
{
   final List<Jobappliedpage> joblist;

  const Jobgetsuccess({this.joblist});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [joblist];
}
class Jobgetfail extends JobappliedlistState
{
   final String error;
  Jobgetfail(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}
class JoblistLoading extends JobappliedlistState{}
