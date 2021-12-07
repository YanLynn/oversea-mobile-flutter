part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

class JobInitial extends JobState {
  const JobInitial();
  @override
  List<Object> get props => [];
}

class JobSuccess extends JobState {
  final List<Job> jobs;

  JobSuccess({this.jobs});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [this.jobs];
}

class JobFail extends JobState {
  final String error;
  JobFail(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}

class JobLoading extends JobState {}
