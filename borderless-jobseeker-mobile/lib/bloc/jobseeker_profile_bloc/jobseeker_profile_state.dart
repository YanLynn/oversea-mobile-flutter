part of 'jobseeker_profile_bloc.dart';

abstract class JobseekerProfileState extends Equatable {
  const JobseekerProfileState();

  @override
  List<Object> get props => [];
}

class JobseekerProfileInitial extends JobseekerProfileState {
  const JobseekerProfileInitial();
  @override
  List<Object> get props => [];
}

class UpdateSelfIntroSuccess extends JobseekerProfileState {}

class GetSelfIntroSuccess extends JobseekerProfileState {
  final List<SelfIntroDetail> jobseekers;
  final List<LanguageLevel> language_level;
  final List<Language> languages;

  const GetSelfIntroSuccess(
      this.jobseekers, this.language_level, this.languages);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [jobseekers];
}

class JobseekerProfileLoading extends JobseekerProfileState {}

class JobseekerProfileFailure extends JobseekerProfileState {
  final String error;

  const JobseekerProfileFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
