part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class GetJobList extends JobEvent {
  @override
  List<Object> get props => null;
}
